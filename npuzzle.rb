require_relative 'args_handler'
require_relative 'puzzle_generator'
require_relative 'file_parser'
require_relative 'default_variables'
require_relative 'board'


options = ArgsParser.parse(ARGV)

if options[:path].nil?
  size = options[:size].nil? ? DEFAULT_SIZE : options[:size]
  puzzle = PuzzleGenerator.randomized_puzzle(size)
  board = Board.new(puzzle, 3)
else
  puzzle = FileParser.parse(options[:path])
  board = Board.new(puzzle, 3)
end


