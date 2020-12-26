defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

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
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn,"new.html",changeset: changeset)
    end
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def edit(conn, %{"id" => topic_id}) do

  end
end