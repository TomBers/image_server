defmodule ImageServerWeb.PageController do
  use ImageServerWeb, :controller

  def save_image(conn, %{"img" => img, "user_id" => _user} = params) do
    ImageServer.StoreS3.store_image(img)
    json(conn, params)
  end
end
