defmodule DiscussWeb.User do
  # diz ao Phoenix que sera um MODEL (e usara as funcoes pre-definidas de model
  use Ecto.Schema
  import Ecto.Changeset


  # Mostra como sera o schema dentro do DB
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string

    has_many :topics, DiscussWeb.Topic
    has_many :comments, DiscussWeb.Comment

    timestamps()
  end


  # Changeset Function => usada para representar um Record / Struct on the DB and como nos queremos mudar o DB

  def changeset( struct, params \\ %{}) do
    struct
      |> cast( params, [:email, :provider, :token])
      |> validate_required([:email, :provider, :token])
  end
end