# frozen_string_literal: true

require 'pry'

# require_relative 'board'
require_relative 'queen'

# b = Board.new(8)
# print b.board
# print b.last_row_skip_corners_indexes
# print b.first_column
# print b.last_column
q = Queen.new(8, 'd4')
# print q.position
print q.board.fields
