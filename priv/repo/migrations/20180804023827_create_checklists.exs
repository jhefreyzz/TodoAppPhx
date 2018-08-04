defmodule Todo.Repo.Migrations.CreateChecklists do
  use Ecto.Migration

  def change do
    create table(:checklists) do
      add :title, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
