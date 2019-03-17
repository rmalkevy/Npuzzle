module SolvabilityChecker

  def solvable?
    inversions_puzzle = count_inversions(@board)
    inversions_goal_puzzle = count_inversions(@goal_board)

    if @size % 2
      inversions_puzzle += count_raw_for_number(0, @board)
      inversions_goal_puzzle += count_raw_for_number(0, @goal_board)
    end
    inversions_puzzle % 2 == inversions_goal_puzzle % 2
  end

  def count_inversions(puzzle)
    @pairs = ''
    inversions = 0
    range(1, @size**2).each do |i|
      range(i + 1, @size**2).each do |j|
        if puzzle[:array][j] and puzzle[:array][i] > puzzle[:array][j]
          inversions += 1
          @pairs += "#{puzzle[:array][i]}-#{puzzle[:array][j]}, "
        end
      end
    end
    puts @pairs
    inversions
  end

  private

  def range(a, b)
    a...b
  end

  def count_raw_for_number(number=0, puzzle)
    puzzle[:grid].each_with_index do |raw, i|
      raw.each do |tile|
        if tile == number
          return i
        end
      end
    end
  end

end