defmodule Contactapi.UserController do
  use Contactapi.Web, :controller
  alias Contactapi.User

  def index(conn, _params) do
    users = Contactapi.Repo.all(User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Contactapi.Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end
end