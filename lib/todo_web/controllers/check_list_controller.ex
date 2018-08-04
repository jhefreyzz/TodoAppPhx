defmodule TodoWeb.CheckListController do
  use TodoWeb, :controller

  alias Todo.Todos
  alias Todo.Todos.CheckList

  def index(conn, _params) do
    checklists = Todos.list_checklists()
    render(conn, "index.html", checklists: checklists)
  end

  def new(conn, _params) do
    changeset = Todos.change_check_list(%CheckList{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"check_list" => check_list_params}) do
    case Todos.create_check_list(check_list_params) do
      {:ok, check_list} ->
        conn
        |> put_flash(:info, "Check list created successfully.")
        |> redirect(to: check_list_path(conn, :show, check_list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    check_list = Todos.get_check_list!(id)
    render(conn, "show.html", check_list: check_list)
  end

  def edit(conn, %{"id" => id}) do
    check_list = Todos.get_check_list!(id)
    changeset = Todos.change_check_list(check_list)
    render(conn, "edit.html", check_list: check_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "check_list" => check_list_params}) do
    check_list = Todos.get_check_list!(id)

    case Todos.update_check_list(check_list, check_list_params) do
      {:ok, check_list} ->
        conn
        |> put_flash(:info, "Check list updated successfully.")
        |> redirect(to: check_list_path(conn, :show, check_list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", check_list: check_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    check_list = Todos.get_check_list!(id)
    {:ok, _check_list} = Todos.delete_check_list(check_list)

    conn
    |> put_flash(:info, "Check list deleted successfully.")
    |> redirect(to: check_list_path(conn, :index))
  end
end
