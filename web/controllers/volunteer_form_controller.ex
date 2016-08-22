defmodule Contactapi.VolunteerFormController do
  use Contactapi.Web, :controller

  alias Contactapi.VolunteerForm

  def index(conn, _params) do
    volunteerforms = Repo.all(VolunteerForm)
    render(conn, "index.html", volunteerforms: volunteerforms)
  end

  def new(conn, _params) do
    changeset = VolunteerForm.changeset(%VolunteerForm{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"volunteer_form" => volunteer_form_params}) do
    changeset = VolunteerForm.changeset(%VolunteerForm{}, volunteer_form_params)

    case Repo.insert(changeset) do
      {:ok, _volunteer_form} ->
        conn
        |> put_flash(:info, "Volunteer form created successfully.")
        |> redirect(to: volunteer_form_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    volunteer_form = Repo.get!(VolunteerForm, id)
    render(conn, "show.html", volunteer_form: volunteer_form)
  end

  def edit(conn, %{"id" => id}) do
    volunteer_form = Repo.get!(VolunteerForm, id)
    changeset = VolunteerForm.changeset(volunteer_form)
    render(conn, "edit.html", volunteer_form: volunteer_form, changeset: changeset)
  end

  def update(conn, %{"id" => id, "volunteer_form" => volunteer_form_params}) do
    volunteer_form = Repo.get!(VolunteerForm, id)
    changeset = VolunteerForm.changeset(volunteer_form, volunteer_form_params)

    case Repo.update(changeset) do
      {:ok, volunteer_form} ->
        conn
        |> put_flash(:info, "Volunteer form updated successfully.")
        |> redirect(to: volunteer_form_path(conn, :show, volunteer_form))
      {:error, changeset} ->
        render(conn, "edit.html", volunteer_form: volunteer_form, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    volunteer_form = Repo.get!(VolunteerForm, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(volunteer_form)

    conn
    |> put_flash(:info, "Volunteer form deleted successfully.")
    |> redirect(to: volunteer_form_path(conn, :index))
  end
end
