defmodule DiscussWeb.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

    belongs_to :user, DiscussWeb.User
    has_many :comments, DiscussWeb.Comment
  end

  #faz a validacao das mudancas dentro das tabelas do DB
  # the return vai ser um Changeset objeto
  def changeset(struct, params \\%{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end