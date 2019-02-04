module BoardHelper
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

  def board_neighbors
    neighbors = []
    board = @board[:grid]
    y, x = find_tile_coordinates

    # try to move LEFT
    if x > 0 and board.dig(y, x - 1)
      left_board = Marshal::load(Marshal::dump(board))
      number = left_board[y][x - 1]
      left_board[y][x - 1] = 0
      left_board[y][x] = number
      neighbors << left_board
      p 'left'
      p left_board
    end

    # try to move UP
    if y > 0 and board.dig(y - 1, x)
      up_board = Marshal::load(Marshal::dump(board))
      number = up_board[y - 1][x]
      up_board[y - 1][x] = 0
      up_board[y][x] = number
      neighbors << up_board
      p 'up'
      p up_board
    end

    # try to move RIGHT
    unless board.dig(y, x + 1).nil?
      right_board = Marshal::load(Marshal::dump(board))
      number = right_board[y][x + 1]
      right_board[y][x + 1] = 0
      right_board[y][x] = number
      neighbors << right_board
      p 'right'
      p right_board
    end

    # try to move DOWN
    unless board.dig(y + 1, x).nil?
      down_board = Marshal::load(Marshal::dump(board))
      number = down_board[y + 1][x]
      down_board[y + 1][x] = 0
      down_board[y][x] = number
      neighbors << down_board
      p 'down'
      p down_board
    end
    neighbors
  end

  private

  def find_tile_coordinates(tile=0)
    @board[:grid].each_with_index do |raw, y|
      raw.each_with_index do |number, x|
        if tile == number
          return y, x
        end
      end
    end
  end

  def board_filled?(number)
    number >= @size**2
  end
end

