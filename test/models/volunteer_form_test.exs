defmodule Contactapi.VolunteerFormTest do
  use Contactapi.ModelCase

  alias Contactapi.VolunteerForm

  @valid_attrs %{age: 42, city: "some content", country: "some content", email: "some content", first_name: "some content", gender: "some content", last_name: "some content", participation_type: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VolunteerForm.changeset(%VolunteerForm{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VolunteerForm.changeset(%VolunteerForm{}, @invalid_attrs)
    refute changeset.valid?
  end
end
