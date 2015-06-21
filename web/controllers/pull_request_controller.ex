defmodule ApiScaffold.PullRequestController do
  use ApiScaffold.Web, :controller

  alias ApiScaffold.PullRequest

  plug :scrub_params, "pull_request" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    pull_requests = Repo.all(PullRequest)
    render(conn, "index.json", pull_requests: pull_requests)
  end

  def create(conn, %{"pull_request" => pull_request_params}) do
    changeset = PullRequest.changeset(%PullRequest{}, pull_request_params)

    if changeset.valid? do
      pull_request = Repo.insert(changeset)
      render(conn, "show.json", pull_request: pull_request)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ApiScaffold.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pull_request = Repo.get(PullRequest, id)
    render conn, "show.json", pull_request: pull_request
  end

  def update(conn, %{"id" => id, "pull_request" => pull_request_params}) do
    pull_request = Repo.get(PullRequest, id)
    changeset = PullRequest.changeset(pull_request, pull_request_params)

    if changeset.valid? do
      pull_request = Repo.update(changeset)
      render(conn, "show.json", pull_request: pull_request)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ApiScaffold.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pull_request = Repo.get(PullRequest, id)

    pull_request = Repo.delete(pull_request)
    render(conn, "show.json", pull_request: pull_request)
  end
end
