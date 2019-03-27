require 'priority_queue'
require_relative 'heuristics'


class AStarSearchAlgorithm

  attr_accessor :goal_node, :closed_dict, :opened_dict, :pq, :complexity_in_size, :heuristic

  def initialize(start_node, goal_node, size, heuristic_num)
    @goal_node = goal_node
    @heuristic = Heuristics.new(heuristic_num, size, @goal_node)
    start_node.g = 0
    start_node.h = heuristic.distance(start_node)
    start_node.f = start_node.g + start_node.h
    @closed_dict = {}
    @opened_dict = {start_node.checksum => start_node}
    @pq = PriorityQueue.new
    @pq[start_node.checksum] = start_node.f
    @complexity_in_size = 0
    @path_node = nil
  end

  def search_path
    while opened_dict.size != 0
      pq_checksum, min_value = pq.delete_min
      current = opened_dict.delete(pq_checksum)

      if current.checksum == goal_node.checksum
        # show_path(current)
        return complexity_in_size, closed_dict.size, current.g
      end

      unless closed_dict.include?(current.checksum)
        closed_dict[current.checksum] = current

        neighbors = current.neighbors
        neighbors_size = neighbors.size
        i = 0
        while i < neighbors_size
          (i += 1 and next) if closed_dict.include?(neighbors[i].checksum)
          (i += 1 and next) if opened_dict.include?(neighbors[i].checksum)

          opened_dict[neighbors[i].checksum] = calculate_coefficients(current, neighbors[i])
          opened_dict[neighbors[i].checksum].parent = current
          pq[neighbors[i].checksum] = neighbors[i].f
          @complexity_in_size += 1
          i += 1
        end
      end
    end
  end

  def calculate_coefficients(current_node, neighbour_node)
    neighbour_node.g = current_node.g + 1
    neighbour_node.h = heuristic.distance(neighbour_node)
    neighbour_node.f = neighbour_node.g + neighbour_node.h
    return neighbour_node
  end

  def show_path(current)
    path = []
    while current
      path << current
      current = current.parent
    end
    path.reverse!
    path.each_with_index do |node, i|
      p "Node #{i}"
      node.grid.each do |raw|
        p raw
      end
    end
  end
end