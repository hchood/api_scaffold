defmodule ApiScaffold.BeerControllerTest do
  use ApiScaffold.ConnCase

  alias ApiScaffold.Beer
  @valid_attrs %{abv: 42, description: "derpy beer", name: "derp"}
  @invalid_attrs %{name: ""}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, beer_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    beer = Beer.changeset(%Beer{}, @valid_attrs)
    |> Repo.insert
    conn = get conn, beer_path(conn, :show, beer)
    assert json_response(conn, 200)["data"] == %{
      "id" => beer.id,
      "name" => "derp",
      "description" => "derpy beer",
      "abv" => 42
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, beer_path(conn, :create), beer: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Beer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, beer_path(conn, :create), beer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    new_attrs = %{description: "now with more derp"}
    beer = Beer.changeset(%Beer{}, @valid_attrs)
    |> Repo.insert
    conn = put conn, beer_path(conn, :update, beer), beer: new_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Beer, %{abv: 42, description: "now with more derp", name: "derp"})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    beer = Beer.changeset(%Beer{}, @valid_attrs)
    |> Repo.insert
    conn = put conn, beer_path(conn, :update, beer), beer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    beer = Beer.changeset(%Beer{}, @valid_attrs)
    |> Repo.insert
    conn = delete conn, beer_path(conn, :delete, beer)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Beer, beer.id)
  end
end
