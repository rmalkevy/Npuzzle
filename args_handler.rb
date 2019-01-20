require 'optparse'
require_relative 'errors_handler'

class ArgsParser < ErrorsHandler
  def self.parse(options)
    args = {}

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: npuzzle.rb [options]"

      opts.on('-s', '--size NUMBER', OptionParser::DecimalInteger, 'The size of each side of the puzzle') do |size|
        args[:size] = size
      end

      opts.on('-p', '--path PATH', 'The file path to parse and get puzzle') do |path|
        args[:path] = path
      end

      opts.on('-h', '--help', 'The option to help') do
        puts opts.help
        exit
      end
    end

    begin
      opt_parser.parse!(options)
    rescue Exception => e
      puts "Exception encountered: #{e}"
      exit 1
    end

    return args
  end
end
