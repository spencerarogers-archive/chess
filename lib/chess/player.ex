defmodule Chess.Player do
  def relation(c1, c2) do
    if c1 && c2 do
      cond do
        c1 == c2 ->
          :friendly
        c1 != c2 ->
          :enemy
      end
    else
      nil
    end
  end
end
