defmodule Contactapi.BasicFormTest do
  use Contactapi.ModelCase

  alias Contactapi.BasicForm

  @valid_attrs %{email: "some content", message: "some content", name: "some content", read: true, subject: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BasicForm.changeset(%BasicForm{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BasicForm.changeset(%BasicForm{}, @invalid_attrs)
    refute changeset.valid?
  end
end
