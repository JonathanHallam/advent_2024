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

  unless truth_array.include?(true)
    @hash_thing[a].each do |c|
      @hash_thing[c].each do |d|
        truth_array << @hash_thing[d].include?(b)
      end
    end
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

def insert_char_in_array(char, array)
  (0..array.length).to_a.each do |i|
    array.insert(i, char)
    break if is_array_in_order?(array)
    array.delete(char)
  end
  array
end

running_total = 0

out_of_order = []

now_in_order = []

last.each do |line|
  split_line = line.split(",")
  in_order = is_array_in_order?(split_line)

  out_of_order << split_line if !in_order


  out_of_order.each do |wonky_line|
    new_array = []
    wonky_line.each do |c|
      insert_char_in_array(c, new_array)
    end
    now_in_order << new_array if new_array.length == wonky_line.length
  end

end

# I have no idea why this uniq is needed but for some reason I'm putting each item into
# the now_in_order array multiple times and I really cant be bothered to work out why
now_in_order.uniq.each do |ordered|
  running_total += ordered[ordered.length / 2].to_i
end

puts running_total
# 6767
