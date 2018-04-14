defmodule Subroutine.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string

      add :seed, :string
      add :moves, {:array, :string}

      timestamps()
    end

  end
end
