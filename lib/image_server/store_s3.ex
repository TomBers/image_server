defmodule ImageServer.StoreS3 do
  alias ExAws.S3

  def get_bucket_name do
    # TODO - create more buckets and return a random one
    Enum.random(["autumn-thunder-1061"])
  end

  def store_image(file_name, image_data_base64, bucket_name) do
    image_data_binary = Base.decode64!(image_data_base64, ignore: :whitespace, padding: false)

    S3.put_object(bucket_name, file_name, image_data_binary, content_type: "image/jpeg")
    |> ExAws.request!()
  end

  def get_url(file_name, bucket_name) do
    "https://fly.storage.tigris.dev/#{bucket_name}/#{file_name}"
  end

  # def test do
  #   file_name = "encodeTest7.jpg"
  #   image_data_base64 = ImageServer.TestImage.img()
  #   bucket_name = get_bucket_name()
  #   image_data_binary = Base.decode64!(image_data_base64, ignore: :whitespace, padding: false)

  #   S3.put_object(bucket_name, file_name, image_data_binary, content_type: "image/jpeg")
  #   |> ExAws.request!()
  # end
end
