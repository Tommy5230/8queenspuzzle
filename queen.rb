# frozen_string_literal: true

require 'pry'

class Queen
  attr_reader :position, :board

  require_relative 'board'

  def initialize(board_size, position)
    @board = Board.new(board_size)
    @position = position
  end

  # def covered_fields
  #
  # end
end
