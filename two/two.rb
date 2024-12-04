require 'pry'

readData = File.open("input.txt")
file_data = readData.read

array_data = file_data.split("\n")

def check_safe(b)
  sorted = b.sort

  return false unless ( b == sorted || b == sorted.reverse ) && ( b.uniq.length == b.length )

  appropriate_gaps = true

  b.each_with_index do |n, i|
    next if (i + 1) == b.length || !appropriate_gaps
    next_diff = (n.to_i - b[i + 1].to_i).abs
    unless next_diff > 0 && next_diff <= 3
      appropriate_gaps = false
    end
  end

  appropriate_gaps
end

total_safe = 0

array_data.each do |a|
  ar = a.split.map!(&:to_i)
  if check_safe(ar)
    total_safe += 1 
  else
    boolean_array = ar.map.with_index do |_x, i|
      check_safe(ar.first(i) + ar.last(ar.length - (i + 1)))
    end
    total_safe += 1 if boolean_array.include?(true)
  end
end

puts total_safe