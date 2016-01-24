defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @white :white
  @black :black

  def white do
    @white
  end

  def black do
    @black
  end

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
