defmodule Chatbox.RoomChannel do
  use Phoenix.Channel
  use Guardian.Channel
  alias Chatbox.Messages
  alias Chatbox.Repo

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user = current_resource(socket)
    IO.puts "CURRENT: #{user}"
    broadcast! socket, "new_msg", %{body: body}
    changeset = Messages.changeset(%Messages{}, %{body: body, room: "lobby", user_id: 1})
    Repo.insert(changeset)
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

intercept ["user_joined"]

  def handle_out("user_joined", msg, socket) do
    if User.ignoring?(socket.assigns[:user], msg.user_id) do
    {:noreply, socket}
    else
    push socket, "user_joined", msg
    {:noreply, socket}
    end
  end
end
