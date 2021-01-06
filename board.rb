# frozen_string_literal: true

#   a1 b1 c1 d1 e1 f1 g1 h1
#
#   a2 b2 c2 d2 e2 f2 g2 h2
#
#   a3 b3 c3 d3 e3 f3 g3 h3
#
#   a4 b4 c4 d4 e4 f4 g4 h4
#
#   a5 b5 c5 d5 e5 f5 g5 h5
#
#   a6 b6 c6 d6 e6 f6 g6 h6
#
#   a7 b7 c7 d7 e7 f7 g7 h7
#
#   a8 b8 c8 d8 e8 f8 g8 h8
#
#
#    0     1     2     3     4     5     6     7
#
#    8     9    10    11    12    13    14    15
#
#   16    17    18    19    20    21    22    23
#
#   24    25    26    27    28    29    30    31
#
#   32    33    34    35    36    37    38    39
#
#   40    41    42    43    44    45    46    47
#
#   48    49    50    51    52    53    54    55
#
#   56    57    58    59    60    61    62    63
#

class Board
  attr_reader :fields, :size

  def initialize(size)
    @size = size
    @fields = []

    (1..size).map do |i|
      ('a'..'z').first(size).map do |el|
        field = el << i.to_s
        @fields.push(field)
      end
    end
  end

  def first_corner_id
    0
  end

  def second_corner_id
    size - 1
  end

  def third_corner_id
    (size**2) - size
  end

  def last_corner_id
    (size**2) - 1
  end

  def first_row
    fields.first(size)
  end

  def first_row_skip_corners_ids
    first_row_with_corners_ids = fields.map.with_index do |_, i|
      i <= second_corner_id ? i : nil
    end.compact
    first_row_with_corners_ids[1..-2]
  end

  def last_row
    fields.last(size)
  end

  def last_row_skip_corners_ids
    last_row_with_corners_ids = fields.map.with_index do |_, i|
      i >= third_corner_id ? i : nil
    end.compact
    last_row_with_corners_ids[1..-2]
  end

  def first_column
    fields.select.with_index { |_, i| ((i + size) % size).zero? }
  end

  def first_column_skip_corners_ids
    first_column_with_corners_ids = fields.map.with_index do |_, i|
      ((i + size) % size).zero? ? i : nil
    end.compact
    first_column_with_corners_ids[1..-2]
  end

  def last_column
    fields.select.with_index { |_, i| ((i + size) % size) == size - 1 }
  end

  def last_column_skip_corners_ids
    last_column_with_corners_ids = fields.map.with_index do |_, i|
      ((i + size) % size) == size - 1 ? i : nil
    end.compact
    last_column_with_corners_ids[1..-2]
  end

  def boundaries
    (first_row + first_column + last_row + last_column).uniq
  end
end
