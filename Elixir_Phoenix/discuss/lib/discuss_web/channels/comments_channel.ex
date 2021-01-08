defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.Repo
  alias DiscussWeb.{Topic, Comment}

  def join("comments:" <> topic_id, _payload, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments},  assign(socket, :topic, topic)}
  end

  def handle_in(comments, %{"content" =>  payload}, socket) do
    topic = socket.assigns.topic
    user_id_temp = socket.assigns.user_id

    changeset = topic
      |> Ecto.build_assoc(:comments, user_id: user_id_temp)
      |> Comment.changeset(%{content: payload})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        # this is the new line of code I added:
        comment = Repo.preload(comment, :user)
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, {:ok, payload}, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end


  end
end