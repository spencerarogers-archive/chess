defmodule Chess.Piece.Pawn do
  def moves do
    [
      fn({x,y}) -> {:move,       {x,   y+1}} end,
      fn({x,y}) -> {:first_move, {x,   y+2}} end,
      fn({x,y}) -> {:capture,    {x+1, y+1}} end,
      fn({x,y}) -> {:capture,    {x-1, y+1}} end,
      fn({x,y}) -> {:en_passant, {x-1, y+1}} end,
      fn({x,y}) -> {:en_passant, {x+1, y+1}} end
    ]
  end
end
