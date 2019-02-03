module BoardHelper
  def prepare_snail_goal_board
    goal_board = Array.new(@size**2, 0).each_slice(@size).to_a
    horizontal_index = 0
    vertical_index = 0
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
      right_down_moves -= 1
      left_up_moves -= 1

      # move left
      (left_up_moves..right_down_moves).reverse_each do |i|
        goal_board[right_down_moves][i] = number
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

    goal_board
  end

  # break if board_filled?(number)
  private

  def board_filled?(number)
    number >= @size**2
  end
end

