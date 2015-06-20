defmodule ApiScaffold.Repo.Migrations.CreateBeer do
  use Ecto.Migration

  def change do
    create table(:Beers) do
      add :name, :string
      add :description, :text
      add :abv, :integer

      timestamps
    end

  end
end
