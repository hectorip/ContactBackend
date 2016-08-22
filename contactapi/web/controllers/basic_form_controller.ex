defmodule Contactapi.BasicFormController do
  use Contactapi.Web, :controller

  alias Contactapi.BasicForm

  def index(conn, _params) do
    basicforms = Repo.all(BasicForm)
    render(conn, "index.html", basicforms: basicforms)
  end

  def new(conn, _params) do
    changeset = BasicForm.changeset(%BasicForm{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"basic_form" => basic_form_params}) do
    changeset = BasicForm.changeset(%BasicForm{}, basic_form_params)

    case Repo.insert(changeset) do
      {:ok, _basic_form} ->
        conn
        |> put_flash(:info, "Basic form created successfully.")
        |> redirect(to: basic_form_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    basic_form = Repo.get!(BasicForm, id)
    render(conn, "show.html", basic_form: basic_form)
  end

  def edit(conn, %{"id" => id}) do
    basic_form = Repo.get!(BasicForm, id)
    changeset = BasicForm.changeset(basic_form)
    render(conn, "edit.html", basic_form: basic_form, changeset: changeset)
  end

  def update(conn, %{"id" => id, "basic_form" => basic_form_params}) do
    basic_form = Repo.get!(BasicForm, id)
    changeset = BasicForm.changeset(basic_form, basic_form_params)

    case Repo.update(changeset) do
      {:ok, basic_form} ->
        conn
        |> put_flash(:info, "Basic form updated successfully.")
        |> redirect(to: basic_form_path(conn, :show, basic_form))
      {:error, changeset} ->
        render(conn, "edit.html", basic_form: basic_form, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    basic_form = Repo.get!(BasicForm, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(basic_form)

    conn
    |> put_flash(:info, "Basic form deleted successfully.")
    |> redirect(to: basic_form_path(conn, :index))
  end

  def create_api(conn, %{"basic_form" => basic_form_params}) do
    changeset = BasicForm.changeset(%BasicForm{}, basic_form_params)

    case Repo.insert(changeset) do
      {:ok, _basic_form} ->
        conn
        |> json(%{message: "successfully added"})
      {:error, changeset} ->
        json(conn, %{message: "Error creating basic form"})
    end
  end
end
