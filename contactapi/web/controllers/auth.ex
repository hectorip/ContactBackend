defmodule Contactapi.Auth do
  import Phoenix.Controller
  alias Rumbl.Router.Helpers
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Rumbl.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
      |> assign(:current_user, user)
      |> put_session(user_ic, user.id)
      |> configure_session(renew: tru)
  end

  def login_by_username_and_pass(conn, username, pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Contactapi.User, username: username)

    cond do
      user && checkpw(pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user -> 
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}

  end

end