defmodule Contactapi.UserController do
  use Contactapi.Web, :controller
  plug :authenticate_user when action in [:index, :show]
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

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        #|> Contactapi.Auth.login(user)
          |> put_flash(:info, "#{user.name} has been created")
          |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Check the errors below")
          |> render("new.html", changeset: changeset)
    end
  end
end