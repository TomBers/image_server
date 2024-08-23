defmodule ImageServer.StoreS3 do
  alias ExAws.S3
  @bucket_name "autumn-thunder-1061"

  # def store_image(img) do
  # bucket_name = "autumn-thunder-1061"

  # ExAws.S3.list_objects(bucket_name) |> ExAws.request() |> IO.inspect()
  # end

  def test do
    # ExAws.S3.list_objects(@bucket_name) |> ExAws.request() |> IO.inspect()
    # img = File.open!("interface.jpeg")
    # {:ok, local_file} = File.read("test.png")
    test_img = ImageServer.TestImage.img()

    S3.put_object(@bucket_name, "test3.png", test_img, content_type: "image/png")
    |> ExAws.request!()
  end
end
