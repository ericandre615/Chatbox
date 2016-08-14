defmodule Chatbox.UserController do
  use Chatbox.Web, :controller

  alias Chatbox.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def create(conn, %{"user" => user_params}) do
    verifiedpw = if strings_match?(user_params["password"], user_params["verify_password"]), do: user_params["password"], else: nil
    
    if verifiedpw do 
      hashed = hashed_password(user_params["password"])
    
      changeset = User.changeset(%User{}, %{"username" => user_params["username"],
        "password" => hashed, "email" => user_params["email"]
      })

      case Repo.insert(changeset) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: user_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
  
      changeset = User.changeset(%User{}, %{"username" => user_params["username"],
        "password" => "notverified", "email" => user_params["email"]
      })

      conn
      |> put_flash(:info, "Passwords do not match")
      |> render("new.html", changeset: changeset)

    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)

    cond do
      user == Guardian.Plug.current_resource(conn) ->
        conn
        |> render("show.html", user: user, changeset: changeset)
      :error ->
        conn
        |> put_flash(:info, "Not authorized")
        |> redirect(to: session_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    cond do
      user == Guardian.Plug.current_resource(conn) ->
        case Repo.update(changeset) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: user_path(conn, :show, user))
          {:error, changeset} ->
            conn
            |> render("show.html", user: user, changeset: changeset)
        end
      :error ->
        conn
        |> put_flash(:info, "No access")
        |> redirect("/")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
