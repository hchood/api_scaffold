defmodule ApiScaffold.PullRequestTest do
  use ApiScaffold.ModelCase

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
    action: "not a real action"
  }

  test "changeset with valid attributes" do
    changeset = PullRequest.changeset(%PullRequest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PullRequest.changeset(%PullRequest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
