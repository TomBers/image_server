defmodule ImageServer.StoreS3 do
  alias ExAws.S3
  @bucket_name "autumn-thunder-1061"

  def store_image(file_name, image_data_base64) do
    image_data_binary = Base.decode64!(image_data_base64, ignore: :whitespace, padding: false)

    S3.put_object(@bucket_name, file_name, image_data_binary, content_type: "image/jpeg")
    |> ExAws.request!()
  end

  def test do
    file_name = "encodeTest7.jpg"
    image_data_base64 = ImageServer.TestImage.img()

    image_data_binary = Base.decode64!(image_data_base64, ignore: :whitespace, padding: false)
    # File.write!(file_name, image_data_binary)

    S3.put_object(@bucket_name, file_name, image_data_binary, content_type: "image/jpeg")
    |> ExAws.request!()
  end
end
