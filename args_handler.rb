require 'optparse'
require_relative 'errors_handler'

ARGV << '-h' if ARGV.empty?

class ArgsParser < ErrorsHandler
  def self.parse(options)
    args = {}

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: npuzzle.rb [options]"

      opts.on('-s', '--size NUMBER', OptionParser::DecimalInteger, 'The size of each side of the puzzle') do |size|
        args[:size] = size.to_i
        if args[:size] < 3
          print_error_and_exit "SIZE must be more than 2!"
        end
      end

      opts.on('-p', '--path PATH', 'The file path to parse and get puzzle') do |path|
        args[:path] = path
      end

      opts.on('-e', '--heuristic H', 'You can choose such heuristics by number: 1 - manhattan_distance, 2 - euclidean_distance, 3 - hamming_distance') do |heuristic|
        args[:heuristic] = heuristic.to_i
        if args[:heuristic] < 1 or args[:heuristic] > 3
          print_error_and_exit "You can only choose such heuristics by number: 1 - manhattan_distance, 2 - euclidean_distance, 3 - hamming_distance"
        end
      end

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    begin
      opt_parser.parse!(options)
      if args.empty?
        puts opt_parser.help
        exit
      end
    rescue Exception => e
      puts e
      exit
    end
    return args
  end
end
