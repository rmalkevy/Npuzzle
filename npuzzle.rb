require_relative 'args_handler'
require_relative 'puzzle_generator'
require_relative 'file_parser'
require_relative 'default_variables'


options = ArgsParser.parse(ARGV)

if options[:path].nil?
  size = options[:size].nil? ? DEFAULT_SIZE : options[:size]
  p PuzzleGenerator.randomized_puzzle(size)
else
  p FileParser.parse(options[:path])
  p FileParser.parse('puzzles/test_puzzle.txt')
end


