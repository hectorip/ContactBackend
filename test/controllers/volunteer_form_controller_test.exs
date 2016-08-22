defmodule Contactapi.VolunteerFormControllerTest do
  use Contactapi.ConnCase

  alias Contactapi.VolunteerForm
  @valid_attrs %{age: 42, city: "some content", country: "some content", email: "some content", first_name: "some content", gender: "some content", last_name: "some content", participation_type: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, volunteer_form_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing volunteerforms"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, volunteer_form_path(conn, :new)
    assert html_response(conn, 200) =~ "New volunteer form"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, volunteer_form_path(conn, :create), volunteer_form: @valid_attrs
    assert redirected_to(conn) == volunteer_form_path(conn, :index)
    assert Repo.get_by(VolunteerForm, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, volunteer_form_path(conn, :create), volunteer_form: @invalid_attrs
    assert html_response(conn, 200) =~ "New volunteer form"
  end

  test "shows chosen resource", %{conn: conn} do
    volunteer_form = Repo.insert! %VolunteerForm{}
    conn = get conn, volunteer_form_path(conn, :show, volunteer_form)
    assert html_response(conn, 200) =~ "Show volunteer form"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, volunteer_form_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    volunteer_form = Repo.insert! %VolunteerForm{}
    conn = get conn, volunteer_form_path(conn, :edit, volunteer_form)
    assert html_response(conn, 200) =~ "Edit volunteer form"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    volunteer_form = Repo.insert! %VolunteerForm{}
    conn = put conn, volunteer_form_path(conn, :update, volunteer_form), volunteer_form: @valid_attrs
    assert redirected_to(conn) == volunteer_form_path(conn, :show, volunteer_form)
    assert Repo.get_by(VolunteerForm, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    volunteer_form = Repo.insert! %VolunteerForm{}
    conn = put conn, volunteer_form_path(conn, :update, volunteer_form), volunteer_form: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit volunteer form"
  end

  test "deletes chosen resource", %{conn: conn} do
    volunteer_form = Repo.insert! %VolunteerForm{}
    conn = delete conn, volunteer_form_path(conn, :delete, volunteer_form)
    assert redirected_to(conn) == volunteer_form_path(conn, :index)
    refute Repo.get(VolunteerForm, volunteer_form.id)
  end
end
