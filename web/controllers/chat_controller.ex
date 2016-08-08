defmodule Chatbox.ChatController do
  use Chatbox.Web, :controller

  alias Chatbox.Messages
  alias Chatbox.Chat

  def index(conn, _params) do
    messages = Messages
    |> where([m], m.room == "lobby")
    |> Repo.all

    render conn, "index.html", messages: messages
  end
end
