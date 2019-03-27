require_relative 'args_handler'
require_relative 'puzzle_generator'
require_relative 'file_parser'
require_relative 'board'
require 'benchmark'

options = ArgsParser.parse(ARGV)

heuristic = options.dig(:heuristic) ? options.dig(:heuristic) : 1 # Optional

if options.dig(:path)
  puzzle = FileParser.parse(options[:path])
  board = Board.new(puzzle, heuristic)
  board.solve_puzzle
elsif options.dig(:size)
  size = options[:size]
  puzzle = PuzzleGenerator.randomized_puzzle(size)
  board = Board.new(puzzle, heuristic)
  board.solve_puzzle
end
