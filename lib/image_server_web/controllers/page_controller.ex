defmodule ImageServerWeb.PageController do
  use ImageServerWeb, :controller

  def save_image(conn, %{"file_name" => file_name, "img" => img, "user_id" => _user} = params) do
    ImageServer.StoreS3.store_image(file_name, img)
    json(conn, params)
  end
end
