defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @pieces [:p, :r, :k, :b, :q, :k]

  def valid_movements(board, {x1,y1}) do
    [{:c, 1}]
  end

  @pieces |> Enum.each fn name ->
    def unquote(name)(color) do
      %Chess.Piece{ name: unquote(name), color: color }
    end
  end
end
