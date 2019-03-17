require_relative 'heuristics'

class AStarSearchAlgorithm

  def self.search_path(board, goal_board)
    goal_node = Node.new(goal_board[:grid])
    start_node = Node.new(board[:grid])
    start_node.g = 0
    start_node.h = Heuristics.manhattan_distance(start_node, goal_node)
    start_node.f = start_node.g + start_node.h
    closed_dict = {}
    opened_dict = {start_node.checksum => start_node}

    while opened_dict.size != 0
      current_checksum = opened_dict.min_by {|key, node| node.f}.first
      current = opened_dict.delete(current_checksum)

      if current.checksum == goal_node.checksum
        show_path(current)
        return
      end

      closed_dict[current.checksum] = current

      current.neighbors.each do |neighbour|
        next if closed_dict.include?(neighbour.checksum)

        unless opened_dict.include?(neighbour.checksum)
          neighbour.g = current.g + 1
          neighbour.h = Heuristics.manhattan_distance(neighbour, goal_node)
          neighbour.f = neighbour.g + neighbour.h
          neighbour.parent = current

          opened_dict[neighbour.checksum] = neighbour
        end
      end
    end
  end


  def self.show_path(current)
    path = []
    while current
      path << current
      current = current.parent
    end
    path.reverse!
    # path.each_with_index do |node, i|
    #   p "Node #{i}"
    #   node.grid.each do |raw|
    #     p raw
    #   end
    # end
  end

end