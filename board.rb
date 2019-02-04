require_relative 'solvability_checker'
require_relative 'board_helper'

class Board
  include SolvabilityChecker
  include BoardHelper

  attr_accessor :board, :size

  def initialize(board, size)
    @size = size
    @board = board
    @goal_board = prepare_snail_goal_board

    @board[:grid].each do |raw| # TODO: delete later
      p raw
    end
    #
    # p @goal_board[:array]
    p board_neighbors
  end



end