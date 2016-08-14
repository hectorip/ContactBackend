defmodule Contactapi.PageController do
  use Contactapi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
