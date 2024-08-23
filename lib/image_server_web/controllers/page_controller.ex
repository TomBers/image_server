defmodule ImageServerWeb.PageController do
  use ImageServerWeb, :controller

  def save_image(conn, %{"file_name" => file_name, "img" => img, "user_id" => _user} = params) do
    ImageServer.StoreS3.store_image(file_name, img)
    # TODO - return image_url
    json(conn, %{img_url: ImageServer.StoreS3.get_url(file_name)})
  end
end
