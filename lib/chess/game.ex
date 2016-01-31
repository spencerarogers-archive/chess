defmodule Chess.Game do
  import Chess.Board
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

  def move(board, {x1, y1}, {x2, y2}) do
    case validate_move(board, {x1,y1}, {x2,y2}) do
      :ok ->
        piece = board |> piece_at({x1, y1})

        board
        |> Map.put({x1, y1}, nil)
        |> Map.put({x2, y2}, piece)
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
