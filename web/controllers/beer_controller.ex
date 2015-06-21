defmodule ApiScaffold.BeerController do
  use ApiScaffold.Web, :controller

  alias ApiScaffold.Beer

  plug :scrub_params, "beer" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    beers = Repo.all(Beer)
    render(conn, "index.json", beers: beers)
  end

  def create(conn, %{"beer" => beer_params}) do
    changeset = Beer.changeset(%Beer{}, beer_params)
# require IEx
# IEx.pry
    if changeset.valid? do
      beer = Repo.insert(changeset)
      render(conn, "show.json", beer: beer)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ApiScaffold.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    beer = Repo.get(Beer, id)
    render conn, "show.json", beer: beer
  end

  def update(conn, %{"id" => id, "beer" => beer_params}) do
    beer = Repo.get(Beer, id)
    changeset = Beer.changeset(beer, beer_params)

    if changeset.valid? do
      beer = Repo.update(changeset)
      render(conn, "show.json", beer: beer)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ApiScaffold.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    beer = Repo.get(Beer, id)

    beer = Repo.delete(beer)
    render(conn, "show.json", beer: beer)
  end
end
