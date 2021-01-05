# frozen_string_literal: true

require 'pry'

require_relative 'board'

b = Board.new(8)
print b.last_row_skip_corners_indexes
