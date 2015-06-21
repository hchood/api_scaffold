defmodule ApiScaffold.PullRequestControllerTest do
  use ApiScaffold.ConnCase

  alias ApiScaffold.PullRequest
  @valid_attrs %{
    action: "created",
    avatar_url: "my-avatar-url",
    created_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010},
    name: "IntrepidPursuits/Derp",
    number: 42,
    username: "hchood"
  }
  @invalid_attrs %{
    action: "derp"
  }

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pull_request_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    pull_request = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    |> Repo.insert
    conn = get conn, pull_request_path(conn, :show, pull_request)
    assert json_response(conn, 200)["data"] == %{
      "id" => pull_request.id,
      "action" => pull_request.action,
      "avatar_url" => pull_request.avatar_url,
      "name" => pull_request.name,
      "number" => pull_request.number,
      "created_at" => Ecto.DateTime.to_iso8601(pull_request.created_at),
      "username" => pull_request.username
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, pull_request_path(conn, :create), pull_request: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PullRequest, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pull_request_path(conn, :create), pull_request: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    pull_request = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    |> Repo.insert
    conn = put conn, pull_request_path(conn, :update, pull_request), pull_request: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PullRequest, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pull_request = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    |> Repo.insert
    conn = put conn, pull_request_path(conn, :update, pull_request), pull_request: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    pull_request = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    |> Repo.insert
    conn = delete conn, pull_request_path(conn, :delete, pull_request)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(PullRequest, pull_request.id)
  end
end
