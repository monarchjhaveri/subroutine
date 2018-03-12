defmodule SubroutineWeb.DungeonController do
  use SubroutineWeb, :controller

  def indexhtml(conn, _params) do
    conn 
    |> put_resp_header("content-type", "text/html; charset=utf-8") 
    |> Plug.Conn.send_file(200, "assets/static/index.html")
  end

  def index(conn, _params) do
    json conn, LevelMap.gen
  end
end