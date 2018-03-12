defmodule LevelMap do
  def gen do
    [
      %Cell{ type: "FLOOR", x: 0, y: 0},
      %Cell{ type: "FLOOR", x: 1, y: 0},
      %Cell{ type: "FLOOR", x: 2, y: 0},
      %Cell{ type: "FLOOR", x: 0, y: 1},
      %Cell{ type: "FLOOR", x: 1, y: 1},
      %Cell{ type: "FLOOR", x: 2, y: 1},
      %Cell{ type: "FLOOR", x: 0, y: 2},
      %Cell{ type: "FLOOR", x: 1, y: 2},
      %Cell{ type: "FLOOR", x: 2, y: 2}
    ]    
  end
end