defmodule Chess.Game do
  use GenServer

  import Chess.Board

  def handle_call(:start, _from, nil) do
    start
  end

  def start do
    board = Chess.Board.new
    active_player = :white

    start(board, active_player)
  end

  def start(board, active_player) do
    IO.puts("#{active_player}'s turn")

    {from, to} = get_move

    active_player =
      case active_player do
        :white ->
          :black
        :black ->
          :white
      end

    board
    |> move(from, to)
    |> display_board
    |> start(active_player)
  end

  def display_board(board) do
    board
    |> Chess.Board.serialize
    |> IO.puts

    board
  end


  def get_move do
    fromX = IO.gets("Select piece (x)") |> String.strip |> String.to_atom
    fromY = IO.gets("Select piece (y)") |> String.strip |> String.to_integer
    IO.puts("move to:")
    toX = IO.gets("Move to (x)") |> String.strip |> String.to_atom
    toY = IO.gets("Move to (y)") |> String.strip |> String.to_integer
    {{fromX, fromY}, {toX, toY}}
  end

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
    # board
    # |> Chess.Piece.valid_movements({x1,y1})
    # |> Enum.member?({x2,y2})
    # |> case do
    #   true ->
    #     :ok
    #   false ->
    #     :invalid
    # end
    :ok
  end
end
