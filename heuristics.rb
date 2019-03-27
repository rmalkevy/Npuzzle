require_relative 'node'

class Heuristics
  attr_accessor :name, :size, :heuristic_map

  def initialize(method_num, size, goal_node)
    @size = size
    heuristic_names = %w[Manhattan Euclidean Hamming]
    method_maps = [:calculate_manhattan_map, :calculate_euclidean_map, :calculate_hamming_map]
    if method_num >= 1 and method_num <= 3
      method_num -= 1
      @name = heuristic_names[method_num]
      @heuristic_map = self.method(method_maps[method_num]).call(goal_node)
    else
      @name = heuristic_names[0]
      @heuristic_map = self.method(method_maps[0]).call(goal_node)
    end
  end

  def calculate_manhattan_map(goal_node)
    numbers = size**2
    range_numbers = (0...numbers).to_a
    manhattan_map = Array.new(size) { Array.new(size) { Array.new(numbers) } }
    manhattan_map.each_with_index do |raw, y|
      raw.each_with_index do |nums, x|
        nums.each_with_index do |num, i|
          y1, x1 = goal_node.tile_coordinates(range_numbers[i])
          manhattan_map[y][x][i] = (x - x1).abs + (y - y1).abs
        end
      end
    end
    return manhattan_map
  end

  def calculate_euclidean_map(goal_node)
    numbers = size**2
    range_numbers = (0...numbers).to_a
    euclidean_map = Array.new(size) { Array.new(size) { Array.new(numbers) } }
    euclidean_map.each_with_index do |raw, y|
      raw.each_with_index do |nums, x|
        nums.each_with_index do |num, i|
          y1, x1 = goal_node.tile_coordinates(range_numbers[i])
          euclidean_map[y][x][i] = (Math.sqrt((x - x1)**2 + (y - y1)**2)).floor
        end
      end
    end
    return euclidean_map
  end

  def calculate_hamming_map(goal_node)
    numbers = size**2
    range_numbers = (0...numbers).to_a
    hamming_map = Array.new(size) { Array.new(size) { Array.new(numbers) } }
    hamming_map.each_with_index do |raw, y|
      raw.each_with_index do |nums, x|
        nums.each_with_index do |num, i|
          y1, x1 = goal_node.tile_coordinates(range_numbers[i])
          hamming_map[y][x][i] = (x - x1).abs + (y - y1).abs ? 1 : 0
        end
      end
    end
    return hamming_map
  end

  def distance(node)
    distance = 0
    y = 0
    while y < size
      x = 0
      while x < size
        distance += heuristic_map[y][x][node.grid[y][x]]
        x += 1
      end
      y += 1
    end
    return distance
  end

  # def self.manhattan_distance(board, goal_board)
  #   distance = 0
  #   goal_board.grid.each_with_index do |raw, y|
  #     raw.each_with_index do |number, x|
  #       y1, x1 = board.tile_coordinates(number)
  #       distance += (x - x1).abs + (y - y1).abs
  #     end
  #   end
  #   return distance
  # end

  # def euclidean_distance(board, goal_board)
  #   distance = 0
  #   goal_board.grid.each_with_index do |raw, y|
  #     raw.each_with_index do |number, x|
  #       x1, y1 = board.tile_coordinates(number)
  #       distance += Math.sqrt((x - x1)**2 + (y - y1)**2)
  #     end
  #   end
  #   return distance.floor
  # end
  #
  # def hamming_distance(board, goal_board) # the number of tiles out of place
  #   distance = 0
  #   goal_board.grid.each_with_index do |raw, y|
  #     raw.each_with_index do |number, x|
  #       x1, y1 = board.tile_coordinates(number)
  #       distance += 1 if (x - x1).abs + (y - y1).abs
  #     end
  #   end
  #   return distance.floor
  # end


end