defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def new(conn, _params) do
    #struct = %Topic{}
    #params = %{}
    #changeset = Topic.changeset(struct, params)
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn,"new.html", changeset: changeset)
  end

"""
  def create(conn, params) do
    #IO.inspect(params)
    %{"topic" => topic} = params
  end
"""

  def create(conn, %{"topic" => topic}) do

    # ex: "topic" => %{"title" => "Rodrigo"}
    # OLD: changeset = Topic.changeset(%Topic{}, topic)

    # conn.assigns[:user] ou  conn.assigns.user
    # NEW
    changeset = conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn,"new.html",changeset: changeset)
    end
  end

  def index(conn, _params) do
    IO.puts "=========="
    IO.inspect(conn.assigns)
    IO.puts "=========="
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn,"edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => new_topic}) do
    """
    Old Way
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, new_topic)
    """

    # Elixir way
    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset( ___ , new)
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, new_topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
          |> put_flash(:info, "Topic Updated")
          |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn,"edit.html",changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
      |> put_flash(:info, "Topic deleted correctly")
      |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
        |> put_flash(:error, "You cannot edit that topic")
        |> redirect(to: Routes.topic_path(conn, :index))
        |> halt()
    end
  end

end