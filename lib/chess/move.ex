defmodule Chess.Move do
  defstruct player: nil, piece: nil, from: nil, to: nil, type: nil

  def create(game, from, to) do
    game.board
    |> Chess.Board.valid_movements(from)
    |> Enum.member?(to)
    |> if do
      piece = Chess.Board.piece_at(game.board, from)
      {:ok, %Chess.Move{
              player: game.active_player,
              piece: Chess.Piece.serialize(piece),
              from: from,
              to: to,
              type: :move}}
    else
      :invalid
    end
  end
end
