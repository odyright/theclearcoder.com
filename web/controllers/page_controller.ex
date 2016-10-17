defmodule Blog.PageController do
  use Blog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", branding: branding()
  end
  
  def info(conn, _params) do
    render conn, "info.html", branding: branding()
  end

  def letsencrypt(conn, _params) do
    text conn, "9pHSwct20qvvH6OFMXtQW-466Zg1sJIh_dtxmMetGxI.l-LgFiN3ROxzE7NvVOoSSICd208sHQTLgE7IC67LhmQ"
  end

  defp branding do
    Repo.all(Blog.Branding)
  end
end
