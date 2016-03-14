defmodule Chess.Piece.Pawn do
  def move_definitions(board, color) do
    dir = Chess.Piece.direction(color)

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
        color
        |> Chess.Piece.home_row?(y1)
        |> case do
          true ->
            space1 = {x1,y1+(1*dir)}
            space2 = {x1,y1+(2*dir)}

            [space1, space2]
            |> Enum.all?(fn(space) -> Chess.Board.unoccupied?(board, space) end)
            |> case do
              true ->
                space2
              false ->
                nil
            end
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

  def moves(board, {x1,y1}) do
    piece = Chess.Board.piece_at(board, {x1,y1})

    board
    |> move_definitions(piece.color)
    |> Enum.map(fn move -> move.({x1,y1}) end)
  end
end
