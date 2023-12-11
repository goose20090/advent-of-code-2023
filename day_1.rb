require_relative 'constants'
require 'debug'

def calibrate str
  num_lines = str.gsub(/[a-zA-Z]/, "").split("\n")

  total = 0

  num_lines.each do |num_str|
    total += (num_str[0] + num_str[-1]).to_i
  end

  puts total
end


puts "Expecting: 142"
print "=> "
print calibrate(TEST_TEXT)

puts

puts "Answer"
print "=> "
print calibrate(INPUT_TEXT)
