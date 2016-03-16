defprotocol Chess.Piece do
  def serialize(piece)
  def moves(piece, board)
end
