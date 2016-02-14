require IEx

defmodule Chess.Game do
  defstruct board: nil, active_player: nil

  import Chess.Board

  def new do
    %Chess.Game {
      board: Chess.Board.new,
      active_player: :white
    }
  end

  def next_player(active_player) do
    case active_player do
      :white ->
        :black
      :black ->
        :white
    end
  end

  def move(game, {x1, y1}, {x2, y2}) do
    board = case validate_move(game.board, {x1,y1}, {x2,y2}) do
      :ok ->
        piece = game.board |> piece_at({x1, y1})

        game.board
        |> Map.put({x1, y1}, nil)
        |> Map.put({x2, y2}, piece)
      :invalid ->
        :invalid
    end

    player = game.active_player |> next_player

    %Chess.Game{board: board, active_player: player}
  end

  def validate_move(board, {x1,y1}, {x2,y2}) do
    # board
    # |> Chess.Piece.valid_movements({x1,y1})
    # |> Enum.member?({x2,y2})
    # |> case do
    #    true ->
    #      :ok
    #    false ->
    #      :invalid
    # end
    :ok
  end
end
