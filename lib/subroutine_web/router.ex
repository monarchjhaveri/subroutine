defmodule SubroutineWeb.Router do
  use SubroutineWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SubroutineWeb do
    get "/", DungeonController, :index
  end

  scope "/api", SubroutineWeb do
    pipe_through(:api)

    get("/", DungeonController, :index)

    post("/users", UserController, :create)
  end
end
