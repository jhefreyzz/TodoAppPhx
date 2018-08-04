defmodule TodoWeb.CheckListControllerTest do
  use TodoWeb.ConnCase

  alias Todo.Todos

  @create_attrs %{completed: true, description: "some description", title: "some title"}
  @update_attrs %{completed: false, description: "some updated description", title: "some updated title"}
  @invalid_attrs %{completed: nil, description: nil, title: nil}

  def fixture(:check_list) do
    {:ok, check_list} = Todos.create_check_list(@create_attrs)
    check_list
  end

  describe "index" do
    test "lists all checklists", %{conn: conn} do
      conn = get conn, check_list_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Checklists"
    end
  end

  describe "new check_list" do
    test "renders form", %{conn: conn} do
      conn = get conn, check_list_path(conn, :new)
      assert html_response(conn, 200) =~ "New Check list"
    end
  end

  describe "create check_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, check_list_path(conn, :create), check_list: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == check_list_path(conn, :show, id)

      conn = get conn, check_list_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Check list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, check_list_path(conn, :create), check_list: @invalid_attrs
      assert html_response(conn, 200) =~ "New Check list"
    end
  end

  describe "edit check_list" do
    setup [:create_check_list]

    test "renders form for editing chosen check_list", %{conn: conn, check_list: check_list} do
      conn = get conn, check_list_path(conn, :edit, check_list)
      assert html_response(conn, 200) =~ "Edit Check list"
    end
  end

  describe "update check_list" do
    setup [:create_check_list]

    test "redirects when data is valid", %{conn: conn, check_list: check_list} do
      conn = put conn, check_list_path(conn, :update, check_list), check_list: @update_attrs
      assert redirected_to(conn) == check_list_path(conn, :show, check_list)

      conn = get conn, check_list_path(conn, :show, check_list)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, check_list: check_list} do
      conn = put conn, check_list_path(conn, :update, check_list), check_list: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Check list"
    end
  end

  describe "delete check_list" do
    setup [:create_check_list]

    test "deletes chosen check_list", %{conn: conn, check_list: check_list} do
      conn = delete conn, check_list_path(conn, :delete, check_list)
      assert redirected_to(conn) == check_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, check_list_path(conn, :show, check_list)
      end
    end
  end

  defp create_check_list(_) do
    check_list = fixture(:check_list)
    {:ok, check_list: check_list}
  end
end
