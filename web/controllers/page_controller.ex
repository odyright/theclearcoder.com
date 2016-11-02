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
    if System.get_env("LETSENCRYPT") == "ON" do 
      text conn, "#{content}#{System.get_env("LETSENCRYPT_RESPONSE")}"
    else
      text conn, ""
    end
  end

  def podcasts(conn, _) do
    render conn, "podcasts.html"
  end
end
