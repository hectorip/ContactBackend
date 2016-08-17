defmodule Contactapi.UserController do
  use Contactapi.Web, :controller
  alias Contactapi.User

  def index(conn, _params) do
    users = Contactapi.Repo.all(User)
    render conn, "index.html", users: users
  end
end