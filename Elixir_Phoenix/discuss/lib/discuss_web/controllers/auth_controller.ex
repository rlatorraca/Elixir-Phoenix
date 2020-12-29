defmodule DiscussWeb.AuthController do
  # diz ao phoenix que é um Controller
  use DiscussWeb, :controller
  plug Ueberauth

  alias DiscussWeb.User
  alias Discuss.Repo

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, Caparams) do
    # Troubleshooting logging info for OAuth
    IO.puts "=========="
    IO.inspect(conn.assigns)
    IO.puts "=========="
    IO.puts "++++++++++"
    IO.inspect(params)
    IO.puts "++++++++++"
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  ##
  ### verifica se o usuario (email) ja esta cadastrado no DB
  ##
  defp insert_or_update_user(changeset) do
    # verifica se existe o email, se nao existir returna nil
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

  ##
  ### Verifica se usuario deve acessar ou nao o sistema
  ##
  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

end