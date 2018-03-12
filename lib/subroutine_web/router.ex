defmodule SubroutineWeb.Router do
  use SubroutineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SubroutineWeb do
    pipe_through :api

    get "/", DungeonController, :index
  end
end
