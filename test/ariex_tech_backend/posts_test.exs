defmodule AriexTechBackend.PostsTest do
  use AriexTechBackend.DataCase

  alias AriexTechBackend.Posts

  describe "posts" do
    alias AriexTechBackend.Posts.Post

    import AriexTechBackend.PostsFixtures

    @invalid_attrs %{id: nil, title: nil, body: nil, normalized_title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{id: "some id", title: "some title", body: "some body", normalized_title: "some normalized_title"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.id == "some id"
      assert post.title == "some title"
      assert post.body == "some body"
      assert post.normalized_title == "some normalized_title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{id: "some updated id", title: "some updated title", body: "some updated body", normalized_title: "some updated normalized_title"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.id == "some updated id"
      assert post.title == "some updated title"
      assert post.body == "some updated body"
      assert post.normalized_title == "some updated normalized_title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
