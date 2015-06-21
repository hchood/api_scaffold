defmodule ApiScaffold.PullRequest do
  use ApiScaffold.Web, :model

  schema "pull_requests" do
    field :action, :string
    field :avatar_url, :string
    field :name, :string
    field :number, :integer
    field :created_at, Ecto.DateTime
    field :username, :string

    timestamps
  end

  @required_fields ~w(action avatar_url name number created_at username)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:action, ["created", "synchronize", "open", "closed"])
  end
end
