defmodule Chess.Board do
  @utf8_to_pieces %{
    "♔" => %Chess.Piece.King{color: :white},
    "♕" => %Chess.Piece.Queen{color: :white},
    "♖" => %Chess.Piece.Rook{color: :white},
    "♗" => %Chess.Piece.Bishop{color: :white},
    "♘" => %Chess.Piece.Knight{color: :white},
    "♙" => %Chess.Piece.Pawn{color: :white},
    "♚" => %Chess.Piece.King{color: :black},
    "♛" => %Chess.Piece.Queen{color: :black},
    "♜" => %Chess.Piece.Rook{color: :black},
    "♝" => %Chess.Piece.Bishop{color: :black},
    "♞" => %Chess.Piece.Knight{color: :black},
    "♟" => %Chess.Piece.Pawn{color: :black}
  }

  @new_board_path "lib/chess/board/new.txt"

  @x_axis [1, 2, 3, 4, 5, 6, 7, 8]
  @y_axis [8, 7, 6, 5, 4, 3, 2, 1]

  @min_x 1
  @min_y 1

  @max_x 8
  @max_y 8

  def piece_to_utf8(piece) do
    case piece do
      nil ->
        ' '
      _ ->
        piece.serialize
    end
  end

  def utf8_to_piece(char) do
    @utf8_to_pieces[char]
  end

  def min_x do
    @min_x
  end

  def min_y do
    @min_y
  end

  def max_x do
    @max_x
  end

  def max_y do
    @max_y
  end

  def direction(color) do
    if(color == :white, do: 1, else: -1)
  end

  def home_row?(color, y) do
    case color do
      :white ->
        y == 2
      :black ->
        y == 7
    end
  end

  def new do
    load(@new_board_path)
  end

  def load(path) do
    path
    |> File.read!
    |> deserialize
  end

  def unoccupied?(board, space) do
    case Chess.Board.piece_at(board, space) do
      nil ->
        true
      _ ->
        false
    end
  end

  def empty_board do
    @y_axis |> Enum.reduce(%{}, fn y, a1 ->
      row = @x_axis |> Enum.reduce(%{}, fn(x, a2) ->
                         a2 |> Map.put({x,y}, nil)
                       end)

      Map.merge(a1, row)
    end)
  end

  def piece_at(board, {x,y}) do
    board[{x,y}]
  end

  def color_at(board, {x,y}) do
    piece = piece_at(board, {x,y})

    if piece do
      piece.color
    else
      nil
    end
  end

  def serialize(board) do
    {:ok, pid} = StringIO.open("")

    @y_axis |> Enum.each(fn y ->
      @x_axis |> Enum.each(fn x ->
        char = board
               |> piece_at({x,y})
               |> piece_to_utf8

        IO.write(pid, char)
      end)
      IO.write(pid, "\n")
    end)

    StringIO.contents(pid)
    |> Tuple.to_list
    |> Enum.join
  end

  def deserialize(str) do
    empty_board
    |> deserialize(@x_axis, @y_axis, String.next_codepoint(str))
  end

  def deserialize(board, [x | x_axis], y_axis, {codepoint, str}) do
    y = y_axis |> List.first

    board
    |> Map.put({x,y}, utf8_to_piece(codepoint))
    |> deserialize(x_axis, y_axis, String.next_codepoint(str))
  end

  def deserialize(board, [], [y | y_axis], {_, str}) do
    board
    |> deserialize(@x_axis, y_axis, String.next_codepoint(str))
  end

  def deserialize(board, x_axis, [], _) do
    board
  end

  def x_to_int(x) do
    <<a>> = "a"
    <<x_int>> = x
    x_int - a + 1
  end

  def valid_movements(board, {x1,y1}) do
    board
    |> Chess.Board.piece_at({x1,y1})
    |> Chess.Piece.moves(board)
    |> Enum.reduce(MapSet.new, fn (move_func, set) ->
      move_func.({x1,y1})
      |> case do
        [head | tail] ->
          [head | tail]
          |> Enum.reduce(set, &(MapSet.put(&2,&1)))
        {x2,y2} ->
          MapSet.put(set, {x2,y2})
        [] ->
          set
        nil ->
          set
      end
    end)
  end
end
