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
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} -> IO.inspect(changeset)
    end
  end
end