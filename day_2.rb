require_relative 'constants'
require 'pry'

def calibrate str

  # split the lines
  lines = str.split(/\n/)

  regex_pattern = build_regex_pattern

  # get the digits characters for each line
  filtered_lines = lines.map{|line| line.scan(regex_pattern).flatten}

  # convert to number form
  digits = filtered_lines.map do |line|
    line.map{|num| HASH.key?(num) ? HASH[num] : num}
  end

  # get the coordinates
  coordinates = digits.map do |line|
    (line.first + line.last).to_i
  end

  # return the total
  puts coordinates.sum
end

def build_regex_pattern
  word_nums = HASH.keys.join("|")
  with_digits = word_nums + "|\\d"
  with_positive_lookahead = "(?=(#{with_digits}))"
  Regexp.new(with_positive_lookahead)
end

HASH = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}

puts "Expecting: 142"
print "=> "
print calibrate(TEST_TEXT)

puts

puts "Expecting: 281"
print "=> "
print calibrate(DAY_2_TEST_TEXT)

puts

puts "Expecting: 83"
print "=> "
print calibrate("eighthree")

puts

puts "Answer"
print "=> "
print calibrate(INPUT_TEXT)
