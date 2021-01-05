# frozen_string_literal: true

require 'pry'

class Board
  attr_reader :board

  def initialize(size)
    @board = []

    (1..size).map do |i|
      ('a'..'z').first(size).map do |el|
        field = el << i.to_s
        @board.push(field)
      end
    end
  end
end
