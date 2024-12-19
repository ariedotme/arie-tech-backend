defmodule AriexTechBackend.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AriexTechBackend.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        id: "some id",
        normalized_title: "some normalized_title",
        title: "some title"
      })
      |> AriexTechBackend.Posts.create_post()

    post
  end
end
