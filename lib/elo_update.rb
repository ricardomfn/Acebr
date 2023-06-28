require 'csv'

def capitalize_names(names)
  return nil if names.nil?

  capitalized_names = names.map { |name| name.capitalize }
  capitalized_names.join(' ')
end

def read_csv_and_update_elo_ratings
  data = CSV.read('public/match_hist.csv', headers: true, col_sep: ';')
  @histmatches = data.map do |row|
    winner_names = row['winner']&.split(' ')
    loser_names = row['loser']&.split(' ')

    winner = capitalize_names(winner_names)
    loser = capitalize_names(loser_names)

    match = {
      date: Date.parse(row[0]),
      winner: winner,
      loser: loser,
      winner_score: row['winner_score'].to_i,
      loser_score: row['loser_score'].to_i
    }
  end
end


def update_elo_ratings
  @histmatches.each do |match|
    @userwinner = User.where(nickname: match[:winner]).first
    @userloser = User.where(nickname: match[:loser]).first
    k_factor = 32
    expected_score_winner = 1.0 / (1 + 10**(((@userloser&.points || 1500) - (@userwinner&.points || 1500)) / 400.0))
    expected_score_loser = 1.0 - expected_score_winner
    points_change_winner = k_factor * (1 - expected_score_winner)
    points_change_loser = k_factor * (0 - expected_score_loser)
    @userwinner.points += points_change_winner if @userwinner
    @userloser.points += points_change_loser if @userloser
    @userwinner.save! if @userwinner
    @userloser.save! if @userloser
  end
end

def oldhist
  data = CSV.read('public/match_hist.csv', headers: true, col_sep: ';')
  @histmatches = data.map do |row|
    winner_names = row['winner']&.split(' ')
    loser_names = row['loser']&.split(' ')

    winner = capitalize_names(winner_names)
    loser = capitalize_names(loser_names)

    oldmatch = Match.create({
      address: "Guanambi, Brasil",
      match_type: "Desafio",
      modality: "Simple",
      price: "1",
      level: "0",
      date: Date.parse(row[0]),
      winner: winner,
      winner_score: row['winner_score'].to_i,
      loser: loser,
      loser_score: row['loser_score'].to_i,
      archived: true,
      user_id: User.last.id
    })
    if oldmatch.valid? # Check if the object passes validations
      oldmatch.save!
      p "Match saved successfully!"
    else
      p oldmatch.errors.full_messages # Print out the error messages
    end
  end
end

# Run the method to update Elo ratings
read_csv_and_update_elo_ratings
update_elo_ratings
oldhist

#rails runner "require './lib/elo_update'; update_elo_ratings"
