defmodule Contactapi.UserView do
  use Contactapi.Web, :view
  alias Contactapi.User
  def first_name(%User{name: name}) do
    name
      |> String.split(" ")
      |> Enum.at(0)
  end
end