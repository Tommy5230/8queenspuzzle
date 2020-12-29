# chess board
board = []

(1..8).map do |i|
  ('a'..'h').map do |el|
    field =  el << i.to_s
    board.push(field)
  end
end
