require 'digest/sha1'

class Node
  attr_accessor :grid, :parent, :checksum, :h_value, :g, :h, :f, :x, :y

  def initialize(grid, y=nil, x=nil)
    @grid = grid
    @parent = nil
    @checksum = Digest::MD5.hexdigest(Marshal::dump(grid))
    @g = 0
    @h = 0
    @f = 0
    @y = y
    @x = x
    @y, @x = tile_coordinates if (x.nil? || y.nil?)
  end

  def neighbors
    neighbors = []

    # try to move LEFT
    if x > 0 and grid.dig(y, x - 1)
      left_board = Marshal::load(Marshal::dump(grid))
      left_board[y][x] = left_board[y][x - 1]
      left_board[y][x - 1] = 0
      neighbors << Node.new(left_board, y, x - 1)
    end

    # try to move UP
    if y > 0 and grid.dig(y - 1, x)
      up_board = Marshal::load(Marshal::dump(grid))
      up_board[y][x] = up_board[y - 1][x]
      up_board[y - 1][x] = 0
      neighbors << Node.new(up_board, y - 1, x)
    end

    # try to move RIGHT
    unless grid.dig(y, x + 1).nil?
      right_board = Marshal::load(Marshal::dump(grid))
      right_board[y][x] = right_board[y][x + 1]
      right_board[y][x + 1] = 0
      neighbors << Node.new(right_board, y, x + 1)
    end

    # try to move DOWN
    unless grid.dig(y + 1, x).nil?
      down_board = Marshal::load(Marshal::dump(grid))
      down_board[y][x] = down_board[y + 1][x]
      down_board[y + 1][x] = 0
      neighbors << Node.new(down_board, y + 1, x)
    end
    neighbors
  end

  def tile_coordinates(tile_value=0)
    grid.each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        if tile_value == number
          return y, x
        end
      end
    end
  end
end