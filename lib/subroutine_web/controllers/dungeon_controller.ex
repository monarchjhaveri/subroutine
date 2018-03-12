defmodule SubroutineWeb.DungeonController do
  use SubroutineWeb, :controller

  def index(conn, _params) do
    json conn, LevelMap.gen
  end
end