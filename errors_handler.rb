class ErrorsHandler
  def self.print_error_and_exit(message)
    puts "\033[31mERROR.\033[m " + "\033[36m#{message}\033[39m"
    exit
  end
end