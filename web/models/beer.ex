defmodule ApiScaffold.Beer do
  use ApiScaffold.Web, :model

  schema "beers" do
    field :name, :string
    field :description, :string
    field :abv, :integer

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(description abv)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
