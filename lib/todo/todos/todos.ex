defmodule Todo.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Todos.CheckList

  @doc """
  Returns the list of checklists.

  ## Examples

      iex> list_checklists()
      [%CheckList{}, ...]

  """
  def list_checklists do
    Repo.all(CheckList)
  end

  @doc """
  Gets a single check_list.

  Raises `Ecto.NoResultsError` if the Check list does not exist.

  ## Examples

      iex> get_check_list!(123)
      %CheckList{}

      iex> get_check_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_check_list!(id), do: Repo.get!(CheckList, id)

  @doc """
  Creates a check_list.

  ## Examples

      iex> create_check_list(%{field: value})
      {:ok, %CheckList{}}

      iex> create_check_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_check_list(attrs \\ %{}) do
    %CheckList{}
    |> CheckList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a check_list.

  ## Examples

      iex> update_check_list(check_list, %{field: new_value})
      {:ok, %CheckList{}}

      iex> update_check_list(check_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_check_list(%CheckList{} = check_list, attrs) do
    check_list
    |> CheckList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CheckList.

  ## Examples

      iex> delete_check_list(check_list)
      {:ok, %CheckList{}}

      iex> delete_check_list(check_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_check_list(%CheckList{} = check_list) do
    Repo.delete(check_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking check_list changes.

  ## Examples

      iex> change_check_list(check_list)
      %Ecto.Changeset{source: %CheckList{}}

  """
  def change_check_list(%CheckList{} = check_list) do
    CheckList.changeset(check_list, %{})
  end
end
