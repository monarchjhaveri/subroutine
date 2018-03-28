defmodule SubroutineWeb.DungeonController do
  use SubroutineWeb, :controller

  def index(conn, _params) when conn.request_path == "/api" do
    json conn, LevelMap.gen
  end

  def index(conn, _params) do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> Plug.Conn.send_file(200, "assets/static/index.html")
  end
end
