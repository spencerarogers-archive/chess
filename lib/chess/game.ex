defmodule Chess.Game do
  def piece_at(board, {x, y}) do
    board
    |> get_in([x, y])
  end

  def move(board, {x1, y1}, {x2, y2}) do
    piece = board |> piece_at({x1, y1})

    board
    |> put_in([x1, y1], nil)
    |> put_in([x2, y2], piece)
  end
end
