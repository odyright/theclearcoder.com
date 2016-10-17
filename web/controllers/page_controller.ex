defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", branding: branding()
  end
  
  def info(conn, _params) do
    render conn, "info.html", branding: branding()
  end

  def letsencrypt(conn, %{"content" => content}) do
    if System.get_env("LETSENCRYPT") == "ON" do 
      text conn, "#{content}.l-LgFiN3ROxzE7NvVOoSSICd208sHQTLgE7IC67LhmQ"
    else
      text conn, ""
    end
  end

  defp branding do
    Repo.all(Blog.Branding)
  end
end
