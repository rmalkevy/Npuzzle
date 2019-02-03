require_relative 'args_handler'
require_relative 'puzzle_generator'
require_relative 'file_parser'
require_relative 'default_variables'
require_relative 'board'


options = ArgsParser.parse(ARGV)

if options[:path].nil?
  size = options[:size].nil? ? DEFAULT_SIZE : options[:size]
  puzzle = PuzzleGenerator.randomized_puzzle(size)
  board = Board.new(puzzle, 4)
  # p board.board[:grid]
  # p board.board[:grid][0][0]
  # p board.count_inversions
else
  p FileParser.parse(options[:path])
  p FileParser.parse('puzzles/test_puzzle.txt')
end


