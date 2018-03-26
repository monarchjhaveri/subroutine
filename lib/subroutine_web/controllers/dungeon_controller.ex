defmodule SubroutineWeb.DungeonController do
  use SubroutineWeb, :controller

  def indexhtml(conn, _params) do
    conn 
    |> put_resp_header("content-type", "text/html; charset=utf-8") 
    |> Plug.Conn.send_file(200, "assets/static/index.html")
  end

  def index(conn, _params) do
    json conn, build_response(2)
  end

  defp build_response(room_size) do
    %{room: LevelMap.gen(room_size), player: %{x: 1, y: 1}, size: room_size}
  end
end
