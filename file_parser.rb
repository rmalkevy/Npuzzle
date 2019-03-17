require_relative 'errors_handler'

class FileParser < ErrorsHandler

  def self.parse(path)
    data = read_file(path)
    @parsed_data = split_to_arrays(data)
  end

  private

  def self.read_file(path)
    if File.file?(path)
      return File.read(path)
    else
      print_error_and_exit "Put correct path to the file!"
    end
  end

  def self.split_to_arrays(data)
    lines = data.split("\n")
    puzzle = lines.map.with_index do |line, i|
      line = slice_comment(line)
      validate_line(line, i)
      array = line.split(" ")
      array.map(&:to_i).to_a
    end

    puzzle_size = puzzle.shift
    validate_puzzle(puzzle_size, puzzle)

    {size: puzzle_size.first, grid: puzzle, array: puzzle.flatten}
  end

  def self.slice_comment(line)
    line.include?("#") ? line.slice(0...(line.index('#'))) : line
  end

  def self.validate_line(line, index)
    line = line.gsub(/\s+/, "") # delete all whitespaces

    unless line =~ /\A\d+\z/ ? true : false
      print_error_and_exit "Not all chars in the line N_#{index+1} are digits. Please correct your file!"
    end
  end

  def self.validate_puzzle(puzzle_size, puzzle)

    unless puzzle_size.size == 1
      print_error_and_exit "Incorrect first line of file. "+
                               "Please write only one number to determine size of puzzle !"
    end

    size = puzzle_size.first
    puzzle.each_with_index do |arr, i|
      unless arr.size == size
        print_error_and_exit "Incorrect quantity of numbers in the line N_#{i+2}. "+
                                 "Please put #{size} numbers per each line !"
      end
    end

    sequence = puzzle.flatten.sort
    sequence.each_with_index do |num, i|
      return if sequence.size - 1 == i

      if i < sequence.size - 1
        unless sequence[i + 1] - num == 1
          print_error_and_exit "Incorrect numbers in the sequence. Please put valid puzzle !"
        end
      end
    end
  end

end