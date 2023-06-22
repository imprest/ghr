defmodule Ghr.Accounts.Org do
  use Ghr.Schema
  import Ecto.Changeset

  schema "orgs" do
    field :org, :string
    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:org])
    |> validate_required([:org])
  end

end
