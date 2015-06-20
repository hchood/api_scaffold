defmodule ApiScaffold.BeerView do
  use ApiScaffold.Web, :view

  def render("index.json", %{Beers: Beers}) do
    %{data: render_many(Beers, "beer.json")}
  end

  def render("show.json", %{beer: beer}) do
    %{data: render_one(beer, "beer.json")}
  end

  def render("beer.json", %{beer: beer}) do
    %{id: beer.id}
  end
end
