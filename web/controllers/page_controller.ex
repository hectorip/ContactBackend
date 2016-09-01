defmodule Contactapi.PageController do
  use Contactapi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def wakeup(conn, _params) do
    json conn, %{message: "I'm awake now"}
  end
end
