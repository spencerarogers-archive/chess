defmodule Chess.Piece.Pawn do
  def moves(color) do
    dir = case color do
            :w ->
              1
            :b ->
              -1
          end

    [
      fn({x,y}) -> {:move,       {x,   y+(1*dir)}} end
      # fn({x,y}) -> {:first_move, {x,   y+(2*dir)}} end,
      # fn({x,y}) -> {:capture,    {x+1, y+(1*dir)}} end,
      # fn({x,y}) -> {:capture,    {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x+1, y+(1*dir)}} end
    ]
  end
end
