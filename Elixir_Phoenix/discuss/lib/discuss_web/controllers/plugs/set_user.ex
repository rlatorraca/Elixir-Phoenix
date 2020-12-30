defmodule DiscusWeb.Plugs.SetUser do
  # Possue muitas funcoes que pode ser usadas com os Conn objects
  import Plug.Conn
  # Trabalha funcoes da Sessao
  import Phoenix.Controller

  ##
  ### Pegar o ID do DB, fazer um transformacao para ser usado com o object Conn
  ###   em todas as sessoes do usuario (introduzindo o id dentro Conn objeto)
  ##

  alias Discuss.Repo
  alias DiscussWeb.User

  ##
  ### Faz o setup
  ### Chamado 1x
  ##
  def init(_params) do

  end

  ##
  ### Chamado por um Conn objeto e Retorna um Conn objeto
  ### Chamado Muitas Vezes
  ##
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    # Case que respeita a ordem (na primeira instrucao true, sera execucato o coodigo)
    cond do
      user = user_id && Repo.get(User, user_id) ->
        # conn.assigns.user => user struct
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end

end