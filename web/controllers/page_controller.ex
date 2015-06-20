defmodule ApiScaffold.PageController do
  use ApiScaffold.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
