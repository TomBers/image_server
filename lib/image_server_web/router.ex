defmodule ImageServerWeb.Router do
  use ImageServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ImageServerWeb do
    pipe_through :api
    post "/save-image", PageController, :save_image
  end
end
