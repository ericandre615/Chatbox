defmodule Chatbox.PageController do
  use Chatbox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
