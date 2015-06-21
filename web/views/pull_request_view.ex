defmodule ApiScaffold.PullRequestView do
  use ApiScaffold.Web, :view

  def render("index.json", %{pull_requests: pull_requests}) do
    %{data: render_many(pull_requests, "pull_request.json")}
  end

  def render("show.json", %{pull_request: pull_request}) do
    %{data: render_one(pull_request, "pull_request.json")}
  end

  def render("pull_request.json", %{pull_request: pull_request}) do
    %{
      id: pull_request.id,
      action: pull_request.action,
      avatar_url: pull_request.avatar_url,
      name: pull_request.name,
      number: pull_request.number,
      created_at: pull_request.created_at,
      username: pull_request.username
    }
  end
end
