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
      fn({x1,y1}) ->
        space1 = {x1,y1+(1*dir)}
        space2 = {x1,y1+(2*dir)}

        valid = [space1, space2]
        |> Enum.all?(fn(space) -> Chess.Board.unoccupied?(board, space) end)
        |> case do
          true ->
            space2
          false ->
            nil
        end
      end,
      # fn({x,y}) -> {:capture,    {x+1, y+(1*dir)}} end,
      # fn({x,y}) -> {:capture,    {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x+1, y+(1*dir)}} end
    ]
  end
end
