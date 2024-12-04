require 'pry'

readData = File.open("input.txt")
file_data = readData.read

def use_regex(input)
  regex = Regexp.new('\\(([+-]?(?=\\.\\d|\\d)(?:\\d+)?(?:\\.?\\d*))(?:[Ee]([+-]?\\d+))?,([+-]?(?=\\.\\d|\\d)(?:\\d+)?(?:\\.?\\d*))(?:[Ee]([+-]?\\d+))?\\)', Regexp::IGNORECASE)
  regex.match input
end

running_total = 0

file_data.split("mul").each do |x|
  puts x[0..8]
  a = use_regex(x[0..8]).to_a
  running_total += a[1].to_i * a[3].to_i
end

puts running_total