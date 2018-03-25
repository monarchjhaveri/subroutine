defmodule LevelMap do
  @room_size 2

  def gen do
    gencol @room_size
  end

  defp floor_cell(x, y), do: %Cell{ type: "FLOOR", x: x, y: y }

  defp genrow(list, x, y) when x > @room_size do
    list |> Enum.reverse
  end

  defp genrow(list, x, y) do
    [floor_cell(x, y) | list]
    |> genrow(x + 1, y)
  end

  defp gencol(col) do
    0..col
    |> Enum.map(fn(x) -> genrow([], 0, x) end)
    |> List.flatten
  end
end
