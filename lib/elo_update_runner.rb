require_relative 'elo_update'

def run_elo_update
  read_csv_and_update_elo_ratings
end

run_elo_update


#scalingo run rails runner -e production "require_relative './lib/elo_update_runner'"
