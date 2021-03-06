defmodule Blog.Web.PageController do
  use Blog.Web, :controller
  alias Blog.{Marketing, AcmeChallenge}

  plug :load_branding when action in [:index, :info]

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def info(conn, _params) do
    render conn, "info.html"
  end

  def keybase(conn, _params) do
    conn
    |> put_layout(false)
    |> render("keybase.txt")
  end

  def letsencrypt(conn, %{"content" => content}) do
    text conn, AcmeChallenge.get_response(content)
  end

  def projects(conn, _params) do
    render conn, "projects.html"
  end

  defp load_branding(conn, _) do
    assign(conn, :copy, Marketing.get_copy)
  end
end
