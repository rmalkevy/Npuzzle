require_relative 'node'

class Heuristics
  # TODO: the Manhattan distance will be the sum of the Manhattan distances of all the tiles except the blank tile
  def self.manhattan_distance(board, goal_board)
    distance = 0
    goal_board.grid.each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        y1, x1 = board.tile_coordinates(number)
        distance += (x - x1).abs + (y - y1).abs

      end
    end
    distance
  end

  def self.euclidean_distance(board, goal_board)
    distance = 0
    goal_board.grid.each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        x1, y1 = board.tile_coordinates(number)
        distance += Math.sqrt((x - x1)**2 + (y - y1)**2)
      end
    end
    distance.floor
  end

  def self.hamming_distance(board, goal_board) # the number of tiles out of place
    distance = 0
    goal_board.grid.each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        x1, y1 = board.tile_coordinates(number)
        distance += 1 if (x - x1).abs + (y - y1).abs
      end
    end
    distance.floor
  end


end