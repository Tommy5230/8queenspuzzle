# frozen_string_literal: true

require 'pry'

class Board
  attr_reader :board, :size

  def initialize(size)
    @size = size
    @board = []

    (1..size).map do |i|
      ('a'..'z').first(size).map do |el|
        field = el << i.to_s
        @board.push(field)
      end
    end
  end

  def first_row
    board.first(size)
  end

  def first_row_skip_corners_indexes
    first_row_skip_corners = first_row.map.with_index { |_pos, i| i }
    first_row_skip_corners[1..-2]
  end

  def last_row
    board.last(size)
  end

  def last_row_skip_corners_indexes
    last_row_skip_corners = last_row.map.with_index { |_pos, i| i }
    last_row_skip_corners[1..-2]
  end

  # def boundaries(size)
  # end
end
