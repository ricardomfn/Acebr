require './lib/elo_update'

read_csv_and_update_elo_ratings


#scalingo run rails runner -e production "require_relative './lib/elo_update_runner'"
