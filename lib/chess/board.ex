defmodule Chess.Board do
  import Chess.Piece

  def new do
    %{
      h: %{ 1 => rook(black), 2 => horsey(black), 3 => bishop(black), 4 => queen(black), 5 => king(black), 6 => bishop(black), 7 => horsey(black), 8 => rook(black) },
      g: %{ 1 => pawn(black), 2 => pawn(black),   3 => pawn(black),   4 => pawn(black),  5 => pawn(black), 6 => pawn(black),   7 => pawn(black),   8 => pawn(black) },
      f: %{ 1 => nil,         2 => nil,           3 => nil,           4 => nil,          5 => nil,         6 => nil,           7 => nil,           8 => nil },
      e: %{ 1 => nil,         2 => nil,           3 => nil,           4 => nil,          5 => nil,         6 => nil,           7 => nil,           8 => nil },
      d: %{ 1 => nil,         2 => nil,           3 => nil,           4 => nil,          5 => nil,         6 => nil,           7 => nil,           8 => nil },
      c: %{ 1 => nil,         2 => nil,           3 => nil,           4 => nil,          5 => nil,         6 => nil,           7 => nil,           8 => nil },
      b: %{ 1 => pawn(white), 2 => pawn(white),   3 => pawn(white),   4 => pawn(white),  5 => pawn(white), 6 => pawn(white),   7 => pawn(white),   8 => pawn(white) },
      a: %{ 1 => rook(white), 2 => horsey(white), 3 => bishop(white), 4 => queen(white), 5 => king(white), 6 => bishop(white), 7 => horsey(white), 8 => rook(white) }
    }
  end
end
