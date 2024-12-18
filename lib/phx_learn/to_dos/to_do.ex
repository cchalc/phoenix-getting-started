defmodule PhxLearn.ToDos.ToDo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :deadline, :utc_datetime
    field :done, :boolean, default: false
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(to_do, attrs) do
    to_do
    |> cast(attrs, [:name, :done, :deadline])
    |> validate_required([:name, :done, :deadline])
  end
end
