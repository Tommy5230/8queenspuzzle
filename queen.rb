# frozen_string_literal: true

# require 'pry'

class Queen
  attr_reader :position, :board

  require_relative 'board'

  def initialize(board_size, position)
    @board = Board.new(board_size)
    @position = position
  end

  def column
    position.split('').first
  end

  def row
    position.split('').last
  end

  def vertical
    board.fields.select { |el| el.split('').first == column }
  end

  def horizontal
    board.fields.select { |el| el.split('').last == row }
  end

  def covered_fields
    (vertical + horizontal + traverse_diagonally).uniq
  end

  def position_index
    board.fields.index(position)
  end

  ### code below is to be cleaned up ###

  def traverse_diagonally
    fields_in_range = []

    case position_index
    when first_corner_id
      traverse_SE
    when second_corner_id
      traverse_SW
    when third_corner_id
      traverse_NE
    when last_corner_id
      traverse_NW
    when first_row_skip_corners_ids.include?(position_index)
      traverse_S
    when last_row_skip_corners_ids.include?(position_index)
      traverse_N
    when first_column_skip_corners_ids.include?(position_index)
      traverse_E
    when last_column_skip_corners_ids.include?(position_index)
      traverse_W
    else
      [-9, 7, -7, 9].each do |dir|
        until boundaries.include?(board.fields[position_index])
          fields_in_range << board.fields[position_index]
          position_index += dir
        end
        fields_in_range << board.fields[position_index]
      end
      fields_in_range
    end
  end

  def traverse_N
    traverse_NE + traverse_NW
  end

  def traverse_S
    traverse_SW + traverse_SE
  end

  def traverse_E
    traverse_SE + traverse_NE
  end

  def traverse_W
    traverse_NW + traverse_SW
  end

  def next_NE
    -(board.size - 1)
  end

  def next_NW
    -(board.size + 1)
  end

  def next_SE
    (board.size + 1)
  end

  def next_SW
    (board.size - 1)
  end

  def traverse_NE
    fields_in_range = []

    # next diagonal in NE direction:
    position_index += next_NE

    until boundaries.include?(board.fields[position_index])
      fields_in_range << board.fields[position_index]
      position_index += next_NE
    end
    fields_in_range << board.fields[position_index]
  end

  def traverse_NW
    fields_in_range = []

    # next diagonal in NW direction:
    position_index += next_NW

    until boundaries.include?(board.fields[position_index])
      fields_in_range << board.fields[position_index]
      position_index += next_NW
    end
    fields_in_range << board.fields[position_index]
  end

  def traverse_SE
    fields_in_range = []

    # next diagonal in SE direction:
    position_index += next_SE

    until boundaries.include?(board.fields[position_index])
      fields_in_range << board.fields[position_index]
      position_index += next_SE
    end
    fields_in_range << board.fields[position_index]
  end

  def traverse_SW
    fields_in_range = []

    # next diagonal in SW direction:
    position_index += next_SW

    until boundaries.include?(board.fields[position_index])
      fields_in_range << board.fields[position_index]
      position_index += next_SW
    end
    fields_in_range << board.fields[position_index]
  end
end
