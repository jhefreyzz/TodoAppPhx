defmodule Todo.TodosTest do
  use Todo.DataCase

  alias Todo.Todos

  describe "checklists" do
    alias Todo.Todos.CheckList

    @valid_attrs %{completed: true, description: "some description", title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, title: nil}

    def check_list_fixture(attrs \\ %{}) do
      {:ok, check_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todos.create_check_list()

      check_list
    end

    test "list_checklists/0 returns all checklists" do
      check_list = check_list_fixture()
      assert Todos.list_checklists() == [check_list]
    end

    test "get_check_list!/1 returns the check_list with given id" do
      check_list = check_list_fixture()
      assert Todos.get_check_list!(check_list.id) == check_list
    end

    test "create_check_list/1 with valid data creates a check_list" do
      assert {:ok, %CheckList{} = check_list} = Todos.create_check_list(@valid_attrs)
      assert check_list.completed == true
      assert check_list.description == "some description"
      assert check_list.title == "some title"
    end

    test "create_check_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_check_list(@invalid_attrs)
    end

    test "update_check_list/2 with valid data updates the check_list" do
      check_list = check_list_fixture()
      assert {:ok, check_list} = Todos.update_check_list(check_list, @update_attrs)
      assert %CheckList{} = check_list
      assert check_list.completed == false
      assert check_list.description == "some updated description"
      assert check_list.title == "some updated title"
    end

    test "update_check_list/2 with invalid data returns error changeset" do
      check_list = check_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_check_list(check_list, @invalid_attrs)
      assert check_list == Todos.get_check_list!(check_list.id)
    end

    test "delete_check_list/1 deletes the check_list" do
      check_list = check_list_fixture()
      assert {:ok, %CheckList{}} = Todos.delete_check_list(check_list)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_check_list!(check_list.id) end
    end

    test "change_check_list/1 returns a check_list changeset" do
      check_list = check_list_fixture()
      assert %Ecto.Changeset{} = Todos.change_check_list(check_list)
    end
  end
end
