require IEx

defmodule Chess.Game do
  use GenServer

  import Chess.Board

  def handle_call(:start, _from, nil) do
    start
  end

  def start do
    active_player = :white

    Chess.Board.new
    |> display_board
    |> start(active_player)
  end

  def start(board, active_player) do
    IO.puts("#{active_player}'s turn")

    {from, to} = get_move

    next_player = active_player |> next_player

    board
    |> move(from, to)
    |> display_board
    |> start(next_player)
  end

  def next_player(active_player) do
    case active_player do
      :white ->
        :black
      :black ->
        :white
    end
  end

  def display_board(board) do
    board
    |> Chess.Board.serialize
    |> IO.puts

    board
  end


  def get_move do
    from_x = IO.gets("Select piece (x)") |> String.strip |> String.to_atom
    from_y = IO.gets("Select piece (y)") |> String.strip |> String.to_integer
    IO.puts("move to:")
    to_x = IO.gets("Move to (x)") |> String.strip |> String.to_atom
    to_y = IO.gets("Move to (y)") |> String.strip |> String.to_integer
    {{from_x, from_y}, {to_x, to_y}}
  end

  def move(board, {x1, y1}, {x2, y2}) do
    case validate_move(board, {x1,y1}, {x2,y2}) do
      :ok ->
        piece = board |> piece_at({x1, y1})

        board
        |> Map.put({x1, y1}, nil)
        |> Map.put({x2, y2}, piece)
      :invalid ->
        :invalid
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
