defmodule Chatbox.MessagesTest do
  use Chatbox.ModelCase

  alias Chatbox.Messages

  @valid_attrs %{body: "some content", room: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Messages.changeset(%Messages{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Messages.changeset(%Messages{}, @invalid_attrs)
    refute changeset.valid?
  end
end
