defmodule AriexTechBackendWeb.PostControllerTest do
  use AriexTechBackendWeb.ConnCase

  import AriexTechBackend.PostsFixtures

  alias AriexTechBackend.Posts.Post

  @create_attrs %{
    id: "some id",
    title: "some title",
    body: "some body",
    normalized_title: "some normalized_title"
  }
  @update_attrs %{
    id: "some updated id",
    title: "some updated title",
    body: "some updated body",
    normalized_title: "some updated normalized_title"
  }
  @invalid_attrs %{id: nil, title: nil, body: nil, normalized_title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/api/posts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some body",
               "id" => "some id",
               "normalized_title" => "some normalized_title",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/posts/#{post}", post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some updated body",
               "id" => "some updated id",
               "normalized_title" => "some updated normalized_title",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/api/posts/#{post}", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/api/posts/#{post}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/posts/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
