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
      (horizontal_index..right_down_moves).each do |i|
        goal_board[vertical_index][i] = number
        number += 1
        horizontal_index = i
      end
      break if board_filled?(number)
      vertical_index += 1

      # move down
      (vertical_index..right_down_moves).each do |i|
        goal_board[i][horizontal_index] = number
        number +=1
        vertical_index = i
      end
      break if board_filled?(number)
      right_down_moves -= 1
      horizontal_index -=1

      # move left
      (left_up_moves..horizontal_index).reverse_each do |i|
        goal_board[vertical_index][i] = number
        number += 1
        horizontal_index = i
      end
      break if board_filled?(number)
      vertical_index -= 1
      left_up_moves += 1

      # move up
      (left_up_moves..vertical_index).reverse_each do |i|
        goal_board[i][horizontal_index] = number
        number += 1
        vertical_index = i
      end
      break if board_filled?(number)
      horizontal_index += 1
    end

    goal_board
  end

  # break if board_filled?(number)
  private

  def board_filled?(number)
    number >= @size**2
  end
end

