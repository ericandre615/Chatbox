defmodule Chatbox.SessionController do
  use Chatbox.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in")
    |> redirect(to: session_path(conn, :new))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in")
    |> redirect(to: session_path(conn, :new))
  end

  def  index(conn, _) do
    conn
    |> put_flash(:info, "redriecting user")
    |> redirect(to: user_path(conn, :new))
  end

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
    case Chatbox.Auth.login_by_email_and_pass(conn, user, password, repo: Repo) do
      {:ok, conn} ->
        logged_in_user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Logged In")
        |> redirect(to: user_path(conn, :show, logged_in_user))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
