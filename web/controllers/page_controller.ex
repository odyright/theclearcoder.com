defmodule Blog.PageController do
  use Blog.Web, :controller
  alias Blog.Services.BrandingService

  plug :load_branding when action in [:index, :info]

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def info(conn, _params) do
    render conn, "info.html"
  end

  def letsencrypt(conn, %{"content" => content}) do
    if is_letsencrypt_on?(conn) do 
      text conn, "#{content}#{letsencrypt_response(conn)}"
    else
      text conn, ""
    end
  end

  def projects(conn, _) do
    render conn, "projects.html"
  end

  def keybase(conn, _) do
    conn
    |> put_layout(false)
    |> render("keybase.txt")
  end

  defp load_branding(conn, _) do
    assign(conn, :copy, BrandingService.get_copy)
  end

  defp is_letsencrypt_on?(conn) do
    conn.assigns[:letsencrypt] == "ON" || System.get_env("LETSENCRYPT") == "ON"
  end

  defp letsencrypt_response(conn) do
    if Map.has_key?(conn.assigns, :letsencrypt_response) do
      conn.assigns[:letsencrypt_response]
    else
      System.get_env("LETSENCRYPT_RESPONSE")
    end
  end
end
