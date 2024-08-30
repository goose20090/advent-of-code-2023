require_relative 'constants'

def calibrate str
  # split the lines
  lines = str.split(/\n/)
  # get the digits characters for each line
  digits = lines.map{|line| line.scan(/\d/)}

  # get the coordinates
  coordinates = digits.map{|line| (line.first + line.last).to_i }

  # return the total
  puts coordinates.sum
end


puts "Expecting: 142"
print "=> "
print calibrate(TEST_TEXT)

puts

puts "Answer"
print "=> "
print calibrate(INPUT_TEXT)
