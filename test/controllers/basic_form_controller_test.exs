defmodule Contactapi.BasicFormControllerTest do
  use Contactapi.ConnCase

  alias Contactapi.BasicForm
  @valid_attrs %{email: "some content", message: "some content", name: "some content", read: true, subject: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, basic_form_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing basicforms"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, basic_form_path(conn, :new)
    assert html_response(conn, 200) =~ "New basic form"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, basic_form_path(conn, :create), basic_form: @valid_attrs
    assert redirected_to(conn) == basic_form_path(conn, :index)
    assert Repo.get_by(BasicForm, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, basic_form_path(conn, :create), basic_form: @invalid_attrs
    assert html_response(conn, 200) =~ "New basic form"
  end

  test "shows chosen resource", %{conn: conn} do
    basic_form = Repo.insert! %BasicForm{}
    conn = get conn, basic_form_path(conn, :show, basic_form)
    assert html_response(conn, 200) =~ "Show basic form"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, basic_form_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    basic_form = Repo.insert! %BasicForm{}
    conn = get conn, basic_form_path(conn, :edit, basic_form)
    assert html_response(conn, 200) =~ "Edit basic form"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    basic_form = Repo.insert! %BasicForm{}
    conn = put conn, basic_form_path(conn, :update, basic_form), basic_form: @valid_attrs
    assert redirected_to(conn) == basic_form_path(conn, :show, basic_form)
    assert Repo.get_by(BasicForm, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    basic_form = Repo.insert! %BasicForm{}
    conn = put conn, basic_form_path(conn, :update, basic_form), basic_form: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit basic form"
  end

  test "deletes chosen resource", %{conn: conn} do
    basic_form = Repo.insert! %BasicForm{}
    conn = delete conn, basic_form_path(conn, :delete, basic_form)
    assert redirected_to(conn) == basic_form_path(conn, :index)
    refute Repo.get(BasicForm, basic_form.id)
  end
end
