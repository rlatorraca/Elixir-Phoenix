defmodule DiscussWeb.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
  end

  #faz a validacao das mudancas dentro das tabelas do DB
  # the return vai ser um Changeset objeto
  def changeset(struct, params \\%{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end