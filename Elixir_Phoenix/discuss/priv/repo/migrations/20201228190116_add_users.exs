defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  # $ mix ecto.gen.migration add_users (no SHELL do Linux)
  # $ mix ecto.migrate (no SHELL do Linux)
  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end
  end
end
