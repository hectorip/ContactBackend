defmodule Contactapi.SessionController do
  use Contactapi.Web, :controller

  def new(conn, _) do
    render conn, "new.html" #login
  end

  def create(conn, _params = %{"session" => %{"username" => user, "password" => pass}}) do
    case Contactapi.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo ) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid usename-password cobination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
      |> Contactapi.Auth.logout
      |> redirect(to: page_path(conn, :index))
  end
end