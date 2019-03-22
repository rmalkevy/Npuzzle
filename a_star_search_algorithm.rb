require_relative 'heuristics'
require 'priority_queue'


class AStarSearchAlgorithm

  def self.search_path(start_node, goal_node)
    start_node.g = 0
    start_node.h = Heuristics.manhattan_distance(start_node, goal_node)
    start_node.f = start_node.g + start_node.h
    closed_dict = {}
    opened_dict = {start_node.checksum => start_node}
    pq = PriorityQueue.new
    pq[start_node.checksum] = start_node.f

    while opened_dict.size != 0
      pq_checksum, min_value = pq.delete_min
      # current_checksum = opened_dict.min_by {|key, node| node.f}.first
      current = opened_dict.delete(pq_checksum)

      if current.checksum == goal_node.checksum
        show_path(current)
        return
      end

      unless closed_dict.include?(current.checksum)
        closed_dict[current.checksum] = current

        current.neighbors.each do |neighbour|
          next if closed_dict.include?(neighbour.checksum)

          if !opened_dict.include?(neighbour.checksum)
            opened_dict[neighbour.checksum] = calculate_coefficients(current, neighbour, goal_node)
            opened_dict[neighbour.checksum].parent = current
            pq[neighbour.checksum] = neighbour.f
          elsif opened_dict.include?(neighbour.checksum)
            potentially_new_lesser_g = current.g + 1
            old_g = opened_dict[neighbour.checksum].g
            if old_g > potentially_new_lesser_g
              opened_dict[neighbour.checksum].g = potentially_new_lesser_g
              opened_dict[neighbour.checksum].f = potentially_new_lesser_g + opened_dict[neighbour.checksum].h
              opened_dict[neighbour.checksum].parent = current
              pq[neighbour.checksum] = neighbour.f
            end
          end
        end
      end
    end
  end

  def self.calculate_coefficients(current_node, neighbour_node, goal_node)
    neighbour_node.g = current_node.g + 1
    neighbour_node.h = Heuristics.manhattan_distance(neighbour_node, goal_node)
    neighbour_node.f = neighbour_node.g + neighbour_node.h
    neighbour_node
  end

  def self.show_path(current)
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