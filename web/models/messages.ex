defmodule Chatbox.Messages do
  use Chatbox.Web, :model

  schema "messages" do
    field :room, :string
    field :body, :string
    belongs_to :user, Chatbox.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:room, :body, :user_id])
    |> validate_required([:room, :body])
  end
end
