require_relative 'day_2_constants'
require 'pry'
BALLS_HASH = {
  red: 12,
  green: 13,
  blue: 14
}

def sum_of_indexes_of_valid_games input
  indexes = []
  games = extract_games input
  games.each.with_index(1) do| game, index |
    indexes << index if valid_game?(game)
  end
  indexes.sum
end

def extract_games input
  lines = input.split(/\n/)
  lines.map{|games| games.split(/:/).last.split(";")} # split on : to get rid of "Game", split on ; to get each round of game in separate array
end

def valid_game? game

  game.each do |turn|
    return false if get_count_of_colour(turn, "blue") > BALLS_HASH[:blue]
    return false if get_count_of_colour(turn, "red") > BALLS_HASH[:red]
    return false if get_count_of_colour(turn, "green") > BALLS_HASH[:green]
  end
end

def get_count_of_colour turn, colour
  match = turn.match(/\d+\s(#{colour})/)

  match ? match[0].match(/\d+/)[0].to_i : 0
end

puts "Expecting 8"
print "=> "
print sum_of_indexes_of_valid_games(TEST_TEXT)

puts

puts "Answer"
print "=> "
print sum_of_indexes_of_valid_games(INPUT_TEXT)
