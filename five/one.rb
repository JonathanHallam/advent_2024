require 'pry'

readData = File.open("input.txt")
file_data = readData.read
@data_array = file_data.split("\n")

first = @data_array.first(1176)
last = @data_array - [""] - first

@hash_thing = {}

first.each do |str|
  split = str.split("|")
  if @hash_thing[split[0]]
    @hash_thing[split[0]] << split[1]
  else
    @hash_thing[split[0]] = [split[1]]
  end
end


def is_a_before_b?(a, b)
  return true if @hash_thing[a].include?(b)
  return false if @hash_thing[b].include?(a)
  
  truth_array = @hash_thing[a].map do |c|
    @hash_thing[c].include?(b)
  end

  truth_array.include?(true)
end

def is_array_in_order?(array)
  truth_array = array.map.with_index do |item, index|
    unless index == array.length - 1
      is_a_before_b?(item, array[index +1])
    end 
  end
  
  !truth_array.include?(false)
end

running_total = 0

last.each do |line|
  split_line = line.split(",")
  in_order = is_array_in_order?(split_line)
  running_total += split_line[split_line.length / 2].to_i if in_order
end

puts running_total
# 4462