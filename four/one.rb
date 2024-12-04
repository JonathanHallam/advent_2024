require 'pry'

readData = File.open("input.txt")
file_data = readData.read
@data_array = file_data.split("\n")

running_total = 0

def find_xmas_in(line)
  line.scan(/XMAS/).length
end

def find_horizontal_total
  horizontal_total = 0
  @data_array.each do |line|
    horizontal_total += find_xmas_in(line)
    horizontal_total += find_xmas_in(line.reverse)
  end
  horizontal_total
end

def find_vertical_total
  vertical_total = 0
  transposed = @data_array.map(&:chars).transpose.map(&:join)
  transposed.each do |line|
    vertical_total += find_xmas_in(line)
    vertical_total += find_xmas_in(line.reverse)
  end
  vertical_total
end

def find_diagonal_total
  diagonal_total = 0
  diagonal_boxes.each do |box|
    diag_1 = (0...4).collect { |i| box[i][i] }.join
    diag_2 = (0...4).collect { |i| box[i][-(i + 1)] }.join
    
    
    diagonal_total += 1 if diag_1 == "XMAS"
    diagonal_total += 1 if diag_1 == "SAMX"
    diagonal_total += 1 if diag_2 == "XMAS"
    diagonal_total += 1 if diag_2 == "SAMX"
  end

  diagonal_total
end


def diagonal_boxes
  squares = []
  
  @data_array.map(&:chars).each_with_index do |r, i|
    if i <= @data_array.length - 4
      r.each_with_index do |c, j|
        if j <= r.length - 4
          squares << [
            @data_array[i][j..j+3].chars, 
            @data_array[i+1][j..j+3].chars, 
            @data_array[i+2][j..j+3].chars, 
            @data_array[i+3][j..j+3].chars
          ]
        end
      end
    end
  end
  squares
end

running_total += find_horizontal_total
running_total += find_vertical_total
running_total += find_diagonal_total
puts running_total

# 2397