defmodule ElixirPhoenixWeb.DummyController do
  use ElixirPhoenixWeb, :controller

  def get(conn, _params) do
    text(conn, "Hello World")
  end
end
