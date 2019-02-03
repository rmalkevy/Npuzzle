module BoardHelper
  def prepare_snail_goal_board
    goal_board = Array.new(@size**2, 0).each_slice(@size).to_a
    horizontal_index = 0
    vertical_index = 0
    moves = @size - 1
    number = 1
    step = 0

    while true
      # move right
      (horizontal_index..moves).each do |i|
        goal_board[vertical_index][i] = number
        number += 1
        horizontal_index = i
        # p "right #{goal_board}"
      end
      break if board_filled?(number)
      vertical_index += 1

      # move down
      (vertical_index..moves).each do |i|
        goal_board[i][horizontal_index] = number
        number +=1
        vertical_index = i
        # p "down #{goal_board}"
      end
      break if board_filled?(number)

      # move left
      (step...moves).reverse_each do |i|
        horizontal_index = i
        goal_board[vertical_index][i] = number
        number += 1
        # p "left #{goal_board}"
      end
      break if board_filled?(number)
      moves -= 1
      vertical_index -= 1
      step += 1

      # move up
      (step..vertical_index).reverse_each do |i|
        vertical_index = i
        goal_board[i][horizontal_index] = number
        number += 1
        # p "up #{goal_board}"
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

