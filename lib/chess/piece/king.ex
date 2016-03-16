defmodule Chess.Piece.King do
  defstruct type: :king, color: nil
end

defimpl Chess.Piece, for: Chess.Piece.King do
  def serialize(piece) do
    case piece.color do
      :white -> "♔"
      :black -> "♚"
    end
  end

  def moves(piece, board) do
    []
  end
end
