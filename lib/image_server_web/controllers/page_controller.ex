defmodule ImageServerWeb.PageController do
  use ImageServerWeb, :controller

  alias ImageServer.StoreS3

  def save_image(conn, %{
        "file_name" => file_name,
        "prompt" => prompt,
        "user_id" => user,
        "api_key" => api_key
      }) do
    if(user == System.fetch_env!("USER_API_KEY")) do
      bucket = StoreS3.get_bucket_name()

      ImageServer.GenImage.create_image(
        api_key,
        file_name,
        prompt,
        bucket,
        &StoreS3.store_image/3
      )

      json(conn, %{img_url: ImageServer.StoreS3.get_url(file_name, bucket)})
    else
      json(conn, %{error: "Incorrect API Key"})
    end
  end

  def test_image(conn, _params) do
    :timer.sleep(2000)
    json(conn, %{img_url: "https://placehold.co/512x512"})
  end
end
