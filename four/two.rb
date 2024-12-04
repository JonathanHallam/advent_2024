require 'pry'

readData = File.open("input.txt")
file_data = readData.read
@data_array = file_data.split("\n")

def find_diagonal_total
  diagonal_total = 0
  diagonal_boxes.each do |box|
    diag_1 = (0...3).collect { |i| box[i][i] }.join
    diag_2 = (0...3).collect { |i| box[i][-(i + 1)] }.join
    
    
    diagonal_total += 1 if diag_1 == "MAS" && diag_2 == "MAS"
    diagonal_total += 1 if diag_1 == "MAS" && diag_2 == "SAM"
    diagonal_total += 1 if diag_1 == "SAM" && diag_2 == "MAS"
    diagonal_total += 1 if diag_1 == "SAM" && diag_2 == "SAM"
  end

  diagonal_total
end


def diagonal_boxes
  squares = []
  
  @data_array.map(&:chars).each_with_index do |r, i|
    if i <= @data_array.length - 3
      r.each_with_index do |c, j|
        if j <= r.length - 3
          squares << [
            @data_array[i][j..j+2].chars, 
            @data_array[i+1][j..j+2].chars, 
            @data_array[i+2][j..j+2].chars
          ]
        end
      end
    end
  end
  squares
end

puts find_diagonal_total



