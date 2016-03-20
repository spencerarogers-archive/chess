defmodule Chess.Piece.Pawn do
  defstruct type: :pawn, color: nil

  def move_definitions(board, color) do
    dir = Chess.Board.direction(color)

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
        |> Chess.Board.home_row?(y1)
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
      fn({x1,y1}) ->
        dest = {x1+1, y1+(1*dir)}

        board
        |> Chess.Board.opposing?({x1,y1},dest)
        |> if(do: dest, else: nil)
      end,
      fn({x1,y1}) ->
        dest = {x1-1, y1+(1*dir)}

        board
        |> Chess.Board.opposing?({x1,y1},dest)
        |> if(do: dest, else: nil)
      end
      # fn({x,y}) -> {:en_passant, {x-1, y+(1*dir)}} end,
      # fn({x,y}) -> {:en_passant, {x+1, y+(1*dir)}} end
    ]
  end
end

defimpl Chess.Piece, for: Chess.Piece.Pawn do
  def moves(piece, board) do
    Chess.Piece.Pawn.move_definitions(board, piece.color)
  end

  def serialize(piece) do
    case piece.color do
      :white -> "♙"
      :black -> "♟"
    end
  end
end
