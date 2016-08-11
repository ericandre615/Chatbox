defmodule Chatbox.RoomChannel do
  use Chatbox.Web, :channel
  use Phoenix.Channel
  import Guardian.Phoenix.Socket
  alias Chatbox.Messages
  alias Chatbox.Repo

  def join("room:lobby", %{"guardian_token" => token}, socket) do
    case sign_in(socket, token) do
      {:ok, authed_socket, _guardian_params} ->
        {:ok, %{message: "Welcome"}, authed_socket}
      {:error, reason} ->
        # handle error
        IO.puts "ERROR: #{reason}"
      end
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", payload, socket) do
    #claims = Guardian.Phoenix.Socket.current_claims(socket)
    #jwt = Guardian.Phoenix.Socket.current_token(socket)
    #user = Guardian.Phoenix.Socket.current_resource(socket)
    user = current_resource(socket)
    
    broadcast! socket, "new_msg", %{body: payload["body"], room: payload["topic"], email: user.email}
    changeset = Messages.changeset(%Messages{}, %{body: payload["body"], room: "room:lobby", user_id: user.id })
    
    Repo.insert(changeset)
    
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def handle_out("user_joined", msg, socket) do
    socket.assigns[:user]
    if User.ignoring?(socket.assigns[:user], msg.user_id) do
    {:noreply, socket}
    else
    push socket, "user_joined", msg
    {:noreply, socket}
    end
  end
end
