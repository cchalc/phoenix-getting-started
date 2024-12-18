defmodule PhxLearn.ToDosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxLearn.ToDos` context.
  """

  @doc """
  Generate a to_do.
  """
  def to_do_fixture(attrs \\ %{}) do
    {:ok, to_do} =
      attrs
      |> Enum.into(%{
        deadline: ~U[2024-12-17 06:14:00Z],
        done: true,
        name: "some name"
      })
      |> PhxLearn.ToDos.create_to_do()

    to_do
  end
end
