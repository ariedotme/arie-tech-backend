defmodule AriexTechBackend.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :body, :string
    field :normalized_title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :title, :normalized_title])
    |> validate_required([:body, :title, :normalized_title])
  end
end
