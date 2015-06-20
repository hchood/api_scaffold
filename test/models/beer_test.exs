defmodule ApiScaffold.BeerTest do
  use ApiScaffold.ModelCase

  alias ApiScaffold.Beer

  @valid_attrs %{abv: 42, description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Beer.changeset(%Beer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Beer.changeset(%Beer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
