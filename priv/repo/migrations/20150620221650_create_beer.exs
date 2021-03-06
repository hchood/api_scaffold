defmodule ApiScaffold.Repo.Migrations.CreateBeer do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :name, :string, null: false
      add :description, :text
      add :abv, :integer

      timestamps
    end
  end
end
