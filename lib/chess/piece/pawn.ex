defmodule Chess.Piece.Pawn do
  def moves(board, player) do
    dir = case player do
            :w ->
              1
            :b ->
              -1
          end

    [
      fn({x1,y1}) ->
        {x2,y2} = {x1, y1+(1*dir)}

        case Chess.Board.unoccupied?(board, {x2,y2}) do
          true ->
            {x2, y2}
          false ->
            nil
        end
      end,
      # fn({x,y}) -> {:first_move, {x,   y+(2*dir)}} end,
      # fn({x,y}) -> {:capture,    {x+1, y+(1*dir)}} end,
      # fn({x,y}) -> {:capture,    {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x+1, y+(1*dir)}} end
    ]
  end
end
