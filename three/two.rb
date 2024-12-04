require 'pry'

readData = File.open("input.txt")
file_data = readData.read

def mul_regex(input)
  regex = Regexp.new('mul\\(([+-]?(?=\\.\\d|\\d)(?:\\d+)?(?:\\.?\\d*))(?:[Ee]([+-]?\\d+))?,([+-]?(?=\\.\\d|\\d)(?:\\d+)?(?:\\.?\\d*))(?:[Ee]([+-]?\\d+))?\\)', Regexp::IGNORECASE)
  regex.match input
end

def loop_thing(string_data)
  first_match = mul_regex(string_data)

  if first_match

    mul_index = string_data.index(first_match[0])
    do_index = string_data.index("do()")
    dont_index = string_data.index("don't()")
    
    if mul_index == [mul_index, do_index, dont_index].compact.min || dont_index.nil?
      @running_total += (first_match[1].to_i * first_match[3].to_i)
      new_string = string_data[(string_data.index(mul_regex(string_data)[0]) + mul_regex(string_data)[0].length)..-1]
      loop_thing(new_string) if string_data.index(new_string) != nil
    elsif dont_index < mul_index && mul_index < do_index    
      new_string = string_data[(do_index + 4)..-1]    
      loop_thing(new_string) if string_data.index(new_string) != nil
    elsif do_index < mul_index && mul_index < dont_index
      @running_total += (first_match[1].to_i * first_match[3].to_i)
      new_string = string_data[(string_data.index(mul_regex(string_data)[0]) + mul_regex(string_data)[0].length)..-1]
      loop_thing(new_string) if string_data.index(new_string) != nil
    end
    
  end
end


@running_total = 0

loop_thing(file_data)

puts @running_total
