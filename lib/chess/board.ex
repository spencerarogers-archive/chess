defmodule Chess.Board do
  import Chess.Piece

  def new do
    %{
      h: %{1 => r(:b), 2 => k(:b), 3 => b(:b), 4 => q(:b), 5 => k(:b), 6 => b(:b), 7 => k(:b), 8 => r(:b)},
      g: %{1 => p(:b), 2 => p(:b), 3 => p(:b), 4 => p(:b), 5 => p(:b), 6 => p(:b), 7 => p(:b), 8 => p(:b)},
      f: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      e: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      d: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      c: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      b: %{1 => p(:w), 2 => p(:w), 3 => p(:w), 4 => p(:w), 5 => p(:w), 6 => p(:w), 7 => p(:w), 8 => p(:w)},
      a: %{1 => r(:w), 2 => k(:w), 3 => b(:w), 4 => q(:w), 5 => k(:w), 6 => b(:w), 7 => k(:w), 8 => r(:w)}
    }
  end

  def serialize do
    # TODO
  end

  def deserialize do
    # TODO
  end
end
