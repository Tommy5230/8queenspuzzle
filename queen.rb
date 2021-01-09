# frozen_string_literal: true

class Queen
  attr_reader :position, :board

  require_relative 'board'

  def initialize(board_size, position)
    @board = Board.new(board_size)
    @position = position
  end

  def covered_fields
    (vertical + horizontal + traverse_diagonally).uniq
  end

  def plot_fields
    p = board.fields.map do |field|
      covered_fields.include?(field) ? '--' : field
    end
    board.size.times do
      print p.shift(board.size)
      puts
      puts ' '
    end
  end

  private

  def vertical
    board.fields.select { |el| el.split('').first == column }
  end

  def horizontal
    board.fields.select { |el| el.split('').last == row }
  end

  def column
    position.split('').first
  end

  def row
    position.split('').last
  end

  def position_index
    board.fields.index(position)
  end

  def traverse_diagonally
    fields_in_range = []

    case position_index
    when board.first_corner_id
      traverse_SE
    when board.second_corner_id
      traverse_SW
    when board.third_corner_id
      traverse_NE
    when board.last_corner_id
      traverse_NW
    when *board.first_row_skip_corners_ids
      traverse_S
    when *board.last_row_skip_corners_ids
      traverse_N
    when *board.first_column_skip_corners_ids
      traverse_E
    when *board.last_column_skip_corners_ids
      traverse_W
    else
      directions = [next_NE, next_NW, next_SE, next_SW]
      directions.each do |dir|
        considered_field_id = position_index
        until board.boundaries.include?(board.fields[considered_field_id])
          fields_in_range << board.fields[considered_field_id]
          considered_field_id += dir
        end
        fields_in_range << board.fields[considered_field_id]
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
    next_diag = position_index + next_NE

    until board.boundaries.include?(board.fields[next_diag])
      fields_in_range << board.fields[next_diag]
      next_diag += next_NE
    end
    fields_in_range << board.fields[next_diag]
  end

  def traverse_NW
    fields_in_range = []

    # next diagonal in NW direction:
    next_diag = position_index + next_NW

    until board.boundaries.include?(board.fields[next_diag])
      fields_in_range << board.fields[next_diag]
      next_diag += next_NW
    end
    fields_in_range << board.fields[next_diag]
  end

  def traverse_SE
    fields_in_range = []

    # next diagonal in SE direction:
    next_diag = position_index + next_SE

    until board.boundaries.include?(board.fields[next_diag])
      fields_in_range << board.fields[next_diag]
      next_diag += next_SE
    end
    fields_in_range << board.fields[next_diag]
  end

  def traverse_SW
    fields_in_range = []

    # next diagonal in SW direction:
    next_diag = position_index + next_SW

    until board.boundaries.include?(board.fields[next_diag])
      fields_in_range << board.fields[next_diag]
      next_diag += next_SW
    end
    fields_in_range << board.fields[next_diag]
  end
end
