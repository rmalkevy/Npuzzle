require_relative 'default_variables'

class PuzzleGenerator

  def self.randomized_puzzle(size=DEFAULT_SIZE)
    @puzzle_size = size

    numbers_quantity = size*size
    range = (0...numbers_quantity).to_a

    @digits = count_digits(range[-1])

    array = range.shuffle
    @sliced_random_range = array.each_slice(size).to_a
    create_file_with_puzzle
    { array: array, grid: @sliced_random_range }
  end

  private

  def self.create_file_with_puzzle
    File.open('puzzle.txt', 'w') do |file|
      file.write(@puzzle_size.to_s + "\n")
      @sliced_random_range.each do |arr|
        aligned_arr = align_arr_of_numbers(arr)
        line = aligned_arr.join(' ') + "\n"
        file.write(line)
      end
    end
  end

  def self.count_digits(number)
    # Math.log10(number).to_i + 1 # Faster but has some problem
    number.to_s.length
  end

  def self.align_arr_of_numbers(array)
    array.map do |num|
      remains_digits = @digits - count_digits(num)
      " "*remains_digits + num.to_s
    end
  end
end