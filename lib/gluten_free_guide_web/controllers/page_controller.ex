defmodule GlutenFreeGuideWeb.PageController do
  use GlutenFreeGuideWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
