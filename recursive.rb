# frozen_string_literal: true

require 'pry'

# chess board


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
board = []

(1..8).map do |i|
  ('a'..'h').map do |el|
    field = el << i.to_s
    board.push(field)
  end
end

# def initialize(position, board)
#   @position = position
#   @board = board
# end
#
# def position
#   @position
# end


# print board

# queen

### move to the initializer of a class Queen ?
### (warning; this might require rails support!)
#
# def position(field, board)
#   board.include?(field) ? field : puts "Field doesn\'t exist"
# end

def column(position)
  position.split('').first
end

def row(position)
  position.split('').last
end

def vertical(position, board)
  board.select { |el| el.split('').first == column(position) }
end

def horizontal(position, board)
  board.select { |el| el.split('').last == row(position) }
end

def lines_of_fire(position, board, boundaries)
  lines_of_fire = horizontal(position, board) + vertical(position, board) + traverse_diagonally(position, board, boundaries)
  lines_of_fire.uniq
end

def boundaries(first_corner, last_corner, board)
  (first_row(board) + first_column(first_corner, board) + last_row(board) + last_column(last_corner, board)).uniq
end

def first_row(board)
  board.first(8)
end

def first_row_skip_corners(board)
  first_row(board).map.with_index {|_pos, i| i}[1..-2]
end

def first_column(position = 'a1', board)
  vertical(position, board)
end

def first_column_skip_corners(board)
  first_column(board).map.with_index {|pos, i| i}[1..-2]
end

def last_row(board)
  board.last(8)
end

def last_row_skip_corners(board)
  last_row(board).map.with_index {|pos, i| i}[1..-2]
end

def last_column(position = 'a8', board)
  vertical(position, board)
end

def last_column_skip_corners(board)
  last_column(board).map.with_index {|pos, i| i}[1..-2]
end

def position_index(position, board)
  board.index(position)
end

def traverse_diagonally(position, board, boundaries)
  fields_in_range = []

  position_index = position_index(position, board)
  # corner_indexes.include?(position_index)
  binding.pry

  case position_index
  when 0
    traverse_SE(position, board, boundaries)
  when 7
    traverse_SW(position, board, boundaries)
  when 56
    traverse_NE(position, board, boundaries)
  when 63
    traverse_NW(position, board, boundaries)
  when first_row_skip_corners(board).include?(position_index)
    traverse_S(position, board, boundaries)
  when last_row_skip_corners(board).include?(position_index)
    traverse_N(position, board, boundaries)
  when first_column_skip_corners(board).include?(position_index)
    traverse_E(position, board, boundaries)
  when last_column_skip_corners(board).include?(position_index)
    traverse_W(position, board, boundaries)
  else
    [-9, 7, -7, 9].each do |dir|
      position_index = position_index(position, board)
      until boundaries.include?(board[position_index])
        fields_in_range << board[position_index]
        position_index += dir
      end
      fields_in_range << board[position_index]
    end
    fields_in_range
  end
end

# TRAVERSAL_DIRECTION = {
#   "top-left-corner": traverse_SE(position, board, boundaries),
#   "top-right-corner": traverse_SW(position, board, boundaries),
#   "bottom-left-corner": traverse_NE(position, board, boundaries),
#   "bottom-right-corner": traverse_NW(position, board, boundaries),
#   "top-row-wo-corners": traverse_S(position, board, boundaries),
#   "bottom-row-wo-corners": traverse_N(position, board, boundaries),
#   "left-column-wo-corners": traverse_E(position, board, boundaries),
#   "right-column-wo-corners": traverse_W(position, board, boundaries)
# }

def traverse_N(position, board, boundaries)
  traverse_NE(position, board, boundaries) + traverse_NW(position, board, boundaries)
end

def traverse_S(position, board, boundaries)
  traverse_SW(position, board, boundaries) + traverse_SE(position, board, boundaries)
end

def traverse_E(position, board, boundaries)
  traverse_SE(position, board, boundaries) + traverse_NE(position, board, boundaries)
end

def traverse_W(position, board, boundaries)
  traverse_NW(position, board, boundaries) + traverse_SW(position, board, boundaries)
end

def traverse_NE(position, board, boundaries)
  fields_in_range = []

  # next diagonal in NE direction:
  position_index = position_index(position, board) - 7

  until boundaries.include?(board[position_index])
    fields_in_range << board[position_index]
    position_index -= 7
  end
  fields_in_range << board[position_index]
end

def traverse_NW(position, board, boundaries)
  fields_in_range = []

  # next diagonal in NW direction:
  position_index = position_index(position, board) - 9

  until boundaries.include?(board[position_index])
    fields_in_range << board[position_index]
    position_index -= 9
  end
  fields_in_range << board[position_index]
end

def traverse_SE(position, board, boundaries)
  fields_in_range = []

  # next diagonal in SE direction:
  position_index = position_index(position, board) + 9

  until boundaries.include?(board[position_index])
    fields_in_range << board[position_index]
    position_index += 9
  end
  fields_in_range << board[position_index]
end

def traverse_SW(position, board, boundaries)
  fields_in_range = []

  # next diagonal in SW direction:
  position_index = position_index(position, board) + 7

  until boundaries.include?(board[position_index])
    fields_in_range << board[position_index]
    position_index += 7
  end
  fields_in_range << board[position_index]
end

### ###

def remaining_fields(field, board)
  board - lines_of_fire
end
### CODE EXECUTION ###
# lof = lines_of_fire('a1', board)
bd = boundaries('a1', 'h8', board)
print bd.count
# diag = traverse_NW('d5', board, bd)#+traverse_SW('d5', board, bd)+traverse_NE('d5', board, bd)+traverse_SE('d5', board, bd)
# print diag#.uniq
# diag2 = traverse_diagonally('d5', board, bd)
# print diag2.uniq
# lf = lines_of_fire('b2', board, bd)
# print lf.count
# puts
# print lf
# ne = traverse_NE('a8', board, bd)
# print ne
# print first_row_skip_corners('a1', board)
# print traverse_diagonally('a3', board, bd)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
