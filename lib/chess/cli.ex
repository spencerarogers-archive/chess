defmodule Chess.Cli do
  def start do
    Chess.Game.new
    |> turn
  end

  def turn(game) do
    game
    |> display
    |> move
    |> turn
  end

  def move(game) do
    from_x = IO.gets("Select piece (x)") |> String.strip |> String.to_atom
    from_y = IO.gets("Select piece (y)") |> String.strip |> String.to_integer
    IO.puts("move to:")
    to_x = IO.gets("Move to (x)") |> String.strip |> String.to_atom
    to_y = IO.gets("Move to (y)") |> String.strip |> String.to_integer

    board = Chess.Game.move(game, {from_x, from_y}, {to_x, to_y})
  end

  def display(game) do
    game.board
    |> Chess.Board.serialize
    |> IO.puts

    IO.puts("#{game.active_player}'s turn.")

    game
  end
end
