require 'pry'

readData = File.open("input.txt")
file_data = readData.read

array_data = file_data.split("\n")

total_safe = 0

array_data.each do |a|
  b = a.split.map!(&:to_i)

  sorted = b.sort

  next unless ( b == sorted || b == sorted.reverse ) && ( b.uniq.length == b.length )

  appropriate_gaps = true

  b.each_with_index do |n, i|
    next if (i + 1) == b.length
    next_diff = (n.to_i - b[i + 1].to_i).abs
    unless next_diff > 0 && next_diff <= 3
      appropriate_gaps = false
    end
  end

  total_safe += 1 if appropriate_gaps
end

puts total_safe