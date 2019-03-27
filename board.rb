require_relative 'solvability_checker'
require_relative 'a_star_search_algorithm'
require_relative 'heuristics'

class Board
  include SolvabilityChecker
  attr_accessor :size, :a_star

  def initialize(board, heuristic_num)
    @size = board[:size].to_i
    @heuristic_num = heuristic_num
    @complexity_in_size, @complexity_in_time, @moves = nil

    @board = board
    @goal_board = prepare_snail_goal_board
    goal_node = Node.new(@goal_board[:grid])
    start_node = Node.new(board[:grid])
    @a_star = AStarSearchAlgorithm.new(start_node, goal_node, @size, @heuristic_num)
  end

  def solve_puzzle
    if solvable?
      time = Benchmark.measure {
        @complexity_in_size, @complexity_in_time, @moves = a_star.search_path
      }
      show_info(time)
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

  def show_info(time)
    puts "Real time          = #{time.real}"
    puts "Complexity in time = #{@complexity_in_time}"
    puts "Complexity in size = #{@complexity_in_size}"
    puts "Quantity of moves  = #{@moves}"
    puts "Algorithm          = A*"
    puts "Heuristic          = #{a_star.heuristic.name}"
  end

end