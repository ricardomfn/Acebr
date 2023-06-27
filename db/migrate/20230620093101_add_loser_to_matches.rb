class AddLoserToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :loser, :string
  end
end
