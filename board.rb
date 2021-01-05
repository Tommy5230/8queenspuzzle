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

  # def boundaries(size)
  # end
end
