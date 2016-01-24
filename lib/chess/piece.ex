defmodule Chess.Piece do
  defstruct name: nil, color: nil

  [
    :pawn,
    :rook,
    :horsey,
    :bishop,
    :queen,
    :king
  ] |> Enum.each fn name ->
    def unquote(name)(color) do
      %Chess.Piece{ name: unquote(name), color: color }
    end
  end
end
