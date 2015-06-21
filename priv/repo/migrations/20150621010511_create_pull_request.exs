defmodule ApiScaffold.Repo.Migrations.CreatePullRequest do
  use Ecto.Migration

  def change do
    create table(:pull_requests) do
      add :action, :string, null: false
      add :avatar_url, :string, null: false
      add :name, :string, null: false
      add :number, :integer, null: false
      add :created_at, :datetime, null: false
      add :username, :string, null: false

      timestamps
    end
  end
end
