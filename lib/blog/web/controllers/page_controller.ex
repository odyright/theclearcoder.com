defmodule Blog.Web.PageController do
  use Blog.Web, :controller
  alias Blog.Services.{BrandingService, ChallengeService}

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
    text conn, ChallengeService.get_response(content)
  end

  def projects(conn, _params) do
    render conn, "projects.html"
  end

  defp load_branding(conn, _) do
    assign(conn, :copy, BrandingService.get_copy)
  end
end
