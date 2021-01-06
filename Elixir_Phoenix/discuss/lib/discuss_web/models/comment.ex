defmodule DiscussWeb.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content]}

  schema "comments" do
    field :content, :string
    belongs_to :user, DiscussWeb.User
    belongs_to :topic, DiscussWeb.Topic

    timestamps()
  end

  #faz a validacao das mudancas dentro das tabelas do DB
  # the return vai ser um Changeset objeto
  def changeset(struct, params \\%{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end