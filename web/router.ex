defmodule ApiScaffold.Router do
  use ApiScaffold.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", ApiScaffold do
    pipe_through :api

    resources "/beers", BeerController
  end
end
