defmodule Ghr.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:orgs) do
      add :org, :text, null: false
      timestamps()
    end

    create unique_index(:orgs, [:org])

    create table(:users) do
      add :org_id, references(:orgs, on_delete: :nothing), null: false
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :name, :string, null: false
      add :is_admin, :boolean, null: false, default: false
      add :role, :text, null: false, default: "manager"
      add :confirmed_at, :naive_datetime
      timestamps()
    end

    create unique_index(:users, [:email])
    create index(:users, [:org_id])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
