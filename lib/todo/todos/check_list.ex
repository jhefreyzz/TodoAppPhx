defmodule Todo.Todos.CheckList do
  use Ecto.Schema
  import Ecto.Changeset


  schema "checklists" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(check_list, attrs) do
    check_list
    |> cast(attrs, [:title, :description, :completed])
    |> validate_required([:title, :description, :completed])
  end
end
