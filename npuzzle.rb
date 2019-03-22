require_relative 'args_handler'
require_relative 'puzzle_generator'
require_relative 'file_parser'
require_relative 'default_variables'
require_relative 'board'
require 'benchmark'


options = ArgsParser.parse(ARGV)


if options.dig(:path)
  puzzle = FileParser.parse(options[:path])
  Board.new(puzzle, 3)
elsif options.dig(:size)
  size = options[:size]
  puzzle = PuzzleGenerator.randomized_puzzle(size)
  Board.new(puzzle, size)
else
  puzzle = PuzzleGenerator.randomized_puzzle(DEFAULT_SIZE)
  Board.new(puzzle, DEFAULT_SIZE)
end

# TODO: size must be more or equal to 3