defmodule Chess.Game do
  # def start do
  #   board = Chess.Board.new
  #   active_player = :white

  #   start(board, active_player)
  # end

  # def start(board, active_player) do
  #   {to, from} = get_move(board, active_player)

  #   board
  #   |> move(to, from)
  #   |> start(active_player)
  # end

  def piece_at(board, {x, y}) do
    board
    |> get_in([x, y])
  end

  def move(board, {x1, y1}, {x2, y2}) do
    case validate_move(board, {x1,y1}, {x2,y2}) do
      :ok ->
        piece = board |> piece_at({x1, y1})

        board
        |> put_in([x1, y1], nil)
        |> put_in([x2, y2], piece)
      :invalid ->
        board
    end
  end

  def validate_move(board, {x1,y1}, {x2,y2}) do
    board
    |> Chess.Piece.valid_movements({x1,y1})
    |> Enum.member?({x2,y2})
    |> case do
      true ->
        :ok
      false ->
        :invalid
    end
  end
end
