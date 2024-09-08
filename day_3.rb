require_relative "day_3_constants"
require "pry"


symbol_adjacent_number_summer = Class.new do


  @results_hash = {}

  def initialize
    @two_d_arr = nil
    @results_arr = []
    @results_hash = {}
  end

  def call(input)
    @two_d_arr = input.lines.map { |line| line.chars }

    @two_d_arr.each.with_index do |line, y|
      line.each.with_index do |char, x|
        next unless char.match?(/\d/)
        if has_adjacent_symbol?(x, y)
          add_to_results_hash(x, y, char)
          fill_in_adjacent_numbers(x, y)
        end
      end
    end

    @results_hash.values.each{|chars| add_adjacent_numbers_to_results_arr(chars)}
    @results_arr.sum
  end

  def add_to_results_hash(x, y, char)
    if @results_hash.has_key?(y)
      @results_hash[y][x] = char
    else
      @results_hash[y] = []
      @results_hash[y][x] = char
    end
  end

  def add_adjacent_numbers_to_results_arr(chars)
    current_num = ""
    chars.each do |char|
      if char.nil? && !current_num.empty?
        @results_arr << current_num.to_i
        current_num = ""
      elsif char
        current_num += char
      end
    end
    @results_arr << current_num.to_i if !current_num.empty?
  end

  def fill_in_adjacent_numbers(x, y)
    check_to_left(x, y)
    check_to_right(x, y)
  end

  def check_to_left(x, y)
    value = @two_d_arr[y][x - 1]
    until value.match?(/[^0-9]/)
      @results_hash[y][x - 1] = value
      x -= 1
      value = @two_d_arr[y][x - 1]
    end
  end

  def check_to_right(x, y)
    value = @two_d_arr[y][x + 1]
    until value.nil? || value.match?(/[^0-9]/)
      @results_hash[y][x + 1] = value
      x += 1
      value = @two_d_arr[y][x + 1]
    end
  end

  def has_adjacent_symbol? x_coordinate, y_coordinate
    surrounding_coordinates = generate_surrounding_coordinates(x_coordinate, y_coordinate)
    surrounding_coordinates.any? do |coordinate|
      next unless coordinate_exists?(coordinate)
      @two_d_arr[coordinate[:y]][coordinate[:x]].match?(/[^a-zA-Z0-9.\n]/)
    end
  end

  def coordinate_exists? coordinate
    @two_d_arr[coordinate[:y]][coordinate[:x]]
  rescue NoMethodError
    false
  end

  def generate_surrounding_coordinates(x, y)
    [
      {x: x - 1, y: y},
      {x: x + 1, y: y},
      {x: x, y: y - 1},
      {x: x, y: y + 1},
      {x: x - 1, y: y + 1},
      {x: x - 1, y: y - 1},
      {x: x + 1, y: y - 1},
      {x: x + 1, y: y + 1},
    ]
  end
end


puts "Expecting 4361"
print "=> "
print symbol_adjacent_number_summer.new.call(TEST_TEXT)

puts

puts "Answer"
print "=> "
print symbol_adjacent_number_summer.new.call(INPUT_TEXT)
