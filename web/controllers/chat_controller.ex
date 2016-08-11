defmodule Chatbox.ChatController do
  use Chatbox.Web, :controller

  alias Chatbox.Messages
  alias Chatbox.User
  alias Chatbox.Chat

  def index(conn, _params) do
    messages = Messages
    |> join(:inner, [m], u in assoc(m, :user))
    |> where([m], m.room == "room:lobby")
    |> preload([m, u], [user: u])
    |> Repo.all
    
    render conn, "index.html", messages: messages
  end
end
