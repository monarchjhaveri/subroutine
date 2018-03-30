defmodule SubroutineWeb.DungeonController do
  use SubroutineWeb, :controller

  def index(conn, _params) do
    if conn.request_path == "/api" do
      json(conn, build_response(20))
    else
      conn
      |> put_resp_header("content-type", "text/html; charset=utf-8")
      |> Plug.Conn.send_file(200, "assets/static/index.html")
    end
  end

  defp build_response(room_size) do
    %{room: LevelMap.gen(room_size), size: room_size, player: %{x: 1, y: 1}}
  end
end
