require_relative 'day_2_constants'
require 'pry'
BALLS_HASH = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

MINIMA = {
  "red" => 0,
  "blue" => 0,
  "green" => 0,
}

POWERS = []

def sum_of_power_of_minimum_balls input
  powers = []
  games = extract_games input
  games.each.with_index(1) do| game, index |
    find_minimum_balls game
    power = MINIMA.values.reject(&:zero?).inject(:*)
    powers << power
    reset_minima_hash
  end
  powers.sum
end

def extract_games input
  lines = input.split(/\n/)
  lines.map{|games| games.split(/:/).last.split(";")} # split on : to get rid of "Game", split on ; to get each round of game in separate array
end

def find_minimum_balls game
  game.each do |turn|
    %w(blue red green).each do |colour|
      count = get_count_of_colour(turn, colour)
      MINIMA[colour] = count if count > MINIMA[colour]
    end
  end
end

def get_count_of_colour turn, colour
  match = turn.match(/\d+\s(#{colour})/)

  match ? match[0].match(/\d+/)[0].to_i : 0
end

def reset_minima_hash
  MINIMA.keys.each{|key| MINIMA[key] = 0}
end

puts "Expecting 2286"
print "=> "
print sum_of_power_of_minimum_balls(TEST_TEXT)

puts

puts "Answer"
print "=> "
print sum_of_power_of_minimum_balls(INPUT_TEXT)
