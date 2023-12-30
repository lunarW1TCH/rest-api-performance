defmodule ElixirPhoenixWeb.Router do
  use ElixirPhoenixWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ElixirPhoenixWeb do
    pipe_through(:api)

    get("/get", DummyController, :get)
  end
end
