defmodule Chess.Piece.Pawn do
  def moves do
    [
      fun({x, y}) -> {
        :move, {x, y+1}}
      end,
      fun({x, y}) -> {
        :home_row_move,
        {x, y+2}}
      end,
      fun({x, y}) -> {
        :capture,
        {x+1, y+1}}
      end,
      fun({x, y}) -> {
        :capture,
        {x-1, y+1}}
      end,
      fun({x, y}) -> {
        :en_passant,
        {x-1, y+1}}
      end,
      fun({x, y}) -> {
        :en_passant,
        {x+1, y+1}}
      end
    ]
  end
end
