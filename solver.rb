# frozen_string_literal: true

# require 'pry'

class Solver
  attr_accessor :main_board
  attr_reader :board_size

  require_relative 'board'
  require_relative 'queen'

  def initialize(board_size)
    @main_board = Board.new(board_size)
    @board_size = board_size
  end

  def main_board_reset
    @main_board = Board.new(board_size)
  end

  def place_the_queen(position)
    queen = Queen.new(board_size, position)
    main_board.fields -= queen.covered_fields
    # puts $main_board.fields.count
    queen.plot_fields
  end

  def fields_count
    main_board.fields.count
  end

  def queen_placing_loop
    while fields_count > 0 do
      next_free_field = main_board.fields.first
      place_the_queen(next_free_field)
      solution_accu << next_free_field
      puts "iteration - #{next_free_field}"
      puts ' '
    end
  end

  # def method_to_be_named
  #   position =
  #   place_the_queen(position)
  # end

  # main_board.fields.map do |field|
  #   # each of the fields will serve as a field for placing the first queen
  #   queen_placing_loop
  #   print solution_accu
  #   main_board_reset
  # end
end
