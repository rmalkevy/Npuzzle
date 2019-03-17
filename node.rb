require 'digest/sha1'

class Node
  attr_accessor :grid, :parent, :checksum, :h_value, :g, :h, :f

  def initialize(grid)
    @grid = grid
    @parent = nil
    @checksum = Digest::SHA1.hexdigest(Marshal::dump(grid))
    @blank_tile = nil # how it can help
    @g = 0
    @h = 0
    @f = 0
  end

  def neighbors
    neighbors = []
    board = @grid
    y, x = tile_coordinates(0)

    # try to move LEFT
    if x > 0 and board.dig(y, x - 1)
      left_board = Marshal::load(Marshal::dump(board))
      number = left_board[y][x - 1]
      left_board[y][x - 1] = 0
      left_board[y][x] = number
      neighbors << Node.new(left_board)
    end

    # try to move UP
    if y > 0 and board.dig(y - 1, x)
      up_board = Marshal::load(Marshal::dump(board))
      number = up_board[y - 1][x]
      up_board[y - 1][x] = 0
      up_board[y][x] = number
      neighbors << Node.new(up_board)
    end

    # try to move RIGHT
    unless board.dig(y, x + 1).nil?
      right_board = Marshal::load(Marshal::dump(board))
      number = right_board[y][x + 1]
      right_board[y][x + 1] = 0
      right_board[y][x] = number
      neighbors << Node.new(right_board)
    end

    # try to move DOWN
    unless board.dig(y + 1, x).nil?
      down_board = Marshal::load(Marshal::dump(board))
      number = down_board[y + 1][x]
      down_board[y + 1][x] = 0
      down_board[y][x] = number
      neighbors << Node.new(down_board)
    end
    neighbors
  end

  def tile_coordinates(tile_value=0)
    @grid.each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        if tile_value == number
          return y, x
        end
      end
    end
  end
end