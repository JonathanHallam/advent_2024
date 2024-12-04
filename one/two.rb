require 'pry'

readData = File.open("input.txt")
file_data = readData.read

array_data = file_data.split("\n").map(&:split)
side_lists = array_data.transpose

first = side_lists[0].sort
second = side_lists[1].sort

total = 0

first.each { |n| total += (n.to_i * second.count(n)) }

puts total