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
  end

  def fields_count
    main_board.fields.count
  end

  def queen_placing_loop(starting_field)
    solution_accu = []
    puts "~~ Starting field - #{starting_field} ~~"
    puts ' '
    place_the_queen(starting_field)
    solution_accu << starting_field
    while fields_count.positive? # fields.count > 0
      next_free_field = main_board.fields.first
      puts "Next free field - #{next_free_field}"
      puts ' '
      place_the_queen(next_free_field)
      solution_accu << next_free_field
    end
    if solution_accu.count == 8
      print "#{solution_accu} ~~~~~ SOLUTION FOUND! ~~~~~"
    else
      print solution_accu # after the last of this - it ran out of fields
    end
    puts ' '
  end

  def run
    main_board.fields.map do |field|
      # each of the fields will serve as a field for placing the first queen
      queen_placing_loop(field)
      main_board_reset
      puts "Finished loop for ===#{field}==="
      puts ' '
    end
    puts 'End of the loop'
  end
end
