defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.Repo
  alias DiscussWeb.{Topic, Comment}

  def join("comments:" <> topic_id, _payload, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(:comments)

    {:ok, %{comments: topic.comments},  assign(socket, :topic_toHandleInd, topic)}
  end

  def handle_in(comments, %{"content" =>  payload}, socket) do
    topic = socket.assigns.topic_toHandleInd

    changeset = topic
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{content: payload})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, {:ok, payload}, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end


  end
end