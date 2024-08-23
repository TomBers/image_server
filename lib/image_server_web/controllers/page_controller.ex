defmodule ImageServerWeb.PageController do
  use ImageServerWeb, :controller

  alias ImageServer.StoreS3

  def save_image(conn, %{"file_name" => file_name, "img" => img, "user_id" => _user}) do
    bucket = StoreS3.get_bucket_name()

    spawn(fn -> StoreS3.store_image(file_name, img, bucket) end)

    json(conn, %{img_url: ImageServer.StoreS3.get_url(file_name, bucket)})
  end
end
