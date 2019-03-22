require_relative 'solvability_checker'
require_relative 'a_star_search_algorithm'

class Board
  include SolvabilityChecker
  attr_accessor :board, :size

  def initialize(board, size)
    @size = size
    @board = board
    @goal_board = prepare_snail_goal_board

    if solvable?
      goal_node = Node.new(@goal_board[:grid])
      start_node = Node.new(@board[:grid])
      time = Benchmark.measure {
        AStarSearchAlgorithm.search_path(start_node, goal_node)
      }
      puts time.real
    else
      p "Puzzle unsolvable!!!"
    end
  end

  def prepare_snail_goal_board
    goal_board = Array.new(@size**2, 0).each_slice(@size).to_a
    right_down_moves = @size - 1
    left_up_moves = 0
    number = 1

    while true
      # move right
      (left_up_moves..right_down_moves).each do |i|
        goal_board[left_up_moves][i] = number
        number += 1
      end
      break if board_filled?(number)
      left_up_moves += 1

      # move down
      (left_up_moves..right_down_moves).each do |i|
        goal_board[i][right_down_moves] = number
        number +=1
      end
      break if board_filled?(number)
      left_up_moves -= 1
      right_down_moves -= 1

      # move left
      (left_up_moves..right_down_moves).reverse_each do |i|
        goal_board[right_down_moves + 1][i] = number
        number += 1
      end
      break if board_filled?(number)
      left_up_moves += 1

      # move up
      (left_up_moves..right_down_moves).reverse_each do |i|
        goal_board[i][left_up_moves - 1] = number
        number += 1
      end
      break if board_filled?(number)
    end

    {array: goal_board.flatten, grid: goal_board}
  end

  def board_filled?(number)
    number >= @size**2
  end

end