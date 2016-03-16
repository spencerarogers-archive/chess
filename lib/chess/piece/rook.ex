defmodule Chess.Piece.Rook do
  defstruct type: :rook, color: nil

  def move_definitions(board, color) do
    [
      fn({x1,y1}) ->
        x2 = x1
        (y1+1)..Chess.Board.max_y
        |> Enum.reduce_while([], fn(y2,acc) ->
          reduce_move_while(acc, board, color, {x2,y2})
        end)
      end,
      fn({x1,y1}) ->
        x2 = x1
        (y1-1)..Chess.Board.min_y
        |> Enum.reduce_while([], fn(y2,acc) ->
          reduce_move_while(acc, board, color, {x2,y2})
        end)
      end,
      fn({x1,y1}) ->
        y2 = y1
        (x1+1)..Chess.Board.max_x
        |> Enum.reduce_while([], fn(x2,acc) ->
          reduce_move_while(acc, board, color, {x2,y2})
        end)
      end,
      fn({x1,y1}) ->
        y2 = y1
        (x1-1)..Chess.Board.min_x
        |> Enum.reduce_while([], fn(x2,acc) ->
          reduce_move_while(acc, board, color, {x2,y2})
        end)
      end
    ]
  end

  defp reduce_move_while(acc, board, active_color, {x2,y2}) do
    Chess.Board.color_at(board, {x2,y2})
    |> Chess.Player.relation(active_color)
    |> case do
     :friendly ->
       {:halt, acc}
     :enemy ->
       {:halt, Enum.concat(acc, [{x2,y2}])}
     nil ->
       {:cont, Enum.concat(acc, [{x2,y2}])}
     end
  end
end

defimpl Chess.Piece, for: Chess.Piece.Rook do
  def serialize(piece) do
    case piece.color do
      :white -> "♖"
      :black -> "♜"
    end
  end

  def moves(piece, board) do
    Chess.Piece.Rook.move_definitions(board, piece.color)
  end
end
