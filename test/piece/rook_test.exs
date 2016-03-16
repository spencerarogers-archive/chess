defmodule Chess.Piece.RookTest do
  use ExUnit.Case
  doctest Chess

  def assert_moves_equal(actual, expected) do
    expected
    |> MapSet.new
    |> MapSet.equal?(actual)
    |> assert
  end

  setup do
    {:ok, [board: Chess.Board.load('test/fixtures/rook.txt')]}
  end

  test "standard movement", context do
    context[:board]
    |> Chess.Board.valid_movements({6,4})
    |> assert_moves_equal([
      {7,4}, {8,4}, {6,3}, {6,5}, {6,6}, {6,7},
      {5,4}, {4,4}, {3,4}, {2,4}, {1,4}
    ])
  end
end
