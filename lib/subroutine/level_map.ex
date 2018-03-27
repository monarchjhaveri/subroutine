defmodule LevelMap do
  @room_size 5
  def default_size, do: @room_size

  def gen(size \\ @room_size) do
    gencol(size)
  end

  defp floor_cell(x, y), do: %Cell{type: "FLOOR", x: x, y: y}
  defp wall_cell(x, y), do: %Cell{type: "WALL", x: x, y: y}

  defp new_cell(%{x: x, y: y, max: max}) do
    if x <= 0 || x >= max || (y <= 0 || y >= max), do: wall_cell(x, y), else: floor_cell(x, y)
  end

  defp genrow(list, %{x: x, max: max}) when x > max do
    list |> Enum.reverse()
  end

  defp genrow(list, opts) do
    %{x: x} = opts
    [new_cell(opts) | list] |> genrow(%{opts | x: x + 1})
  end

  defp gencol(max) do
    0..max
    |> Enum.map(fn y -> genrow([], %{y: y, x: 0, max: max}) end)
    |> List.flatten()
  end
end
