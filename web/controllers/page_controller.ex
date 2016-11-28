defmodule Blog.PageController do
  use Blog.Web, :controller

  plug :load_branding when action in [:index, :info]

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def info(conn, _params) do
    render conn, "info.html"
  end

  defp load_branding(conn, _) do
    content = Repo.all(Blog.Branding)
    assign(conn, :branding, content)
  end

  def letsencrypt(conn, %{"content" => content}) do
    if is_letsencrypt_on?(conn) do 
      text conn, "#{content}#{letsencrypt_response(conn)}"
    else
      text conn, ""
    end
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

  def projects(conn, _) do
    render conn, "projects.html"
  end
end
