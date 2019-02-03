module SolvabilityChecker

  def count_inversions
    @pairs = ''
    inversions = 0
    range(1, @size**2).each do |i|
      range(i + 1, @size**2).each do |j|
        if @board[:array][j] and @board[:array][i] > @board[:array][j]
          inversions += 1
          @pairs += "#{@board[:array][i]}-#{@board[:array][j]}, "
        end
      end
    end
    puts @pairs
    inversions
  end

  def solvable?
    current_inversions = count_inversions
    if @size % 2
      current_inversions += count_raw_for_number
    end
    current_inversions
  end
  private

  def range(a, b)
    a...b
  end

  def count_raw_for_number(number='0')
    @board['grid'].each_with_index do |tile, i|
      if tile == number
        return i / @size
      end
    end
  end

end