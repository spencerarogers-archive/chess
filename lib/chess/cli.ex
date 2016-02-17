defmodule Chess.Cli do
  def start do
    {:ok, Chess.Game.new}
    |> turn
  end

  def turn({:ok, game}) do
    game
    |> display
    |> move
    |> turn
  end

  def turn({:invalid_move, game}) do
    IO.puts("Invalid move.")
    turn({:ok, game})
  end

  def move(game) do
    from_x = IO.gets("Select piece (x)") |> String.strip |> Chess.Board.x_to_int
    from_y = IO.gets("Select piece (y)") |> String.strip |> String.to_integer
    IO.puts("move to:")
    to_x = IO.gets("Move to (x)") |> String.strip |> Chess.Board.x_to_int
    to_y = IO.gets("Move to (y)") |> String.strip |> String.to_integer

    game
    |> Chess.Game.move({from_x, from_y}, {to_x, to_y})
  end

  def display(game) do
    game.board
    |> Chess.Board.serialize
    |> IO.puts

    IO.puts("#{game.active_player}'s turn.")

    game
  end
end
