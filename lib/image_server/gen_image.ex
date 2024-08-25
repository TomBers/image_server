defmodule ImageServer.GenImage do
  @api_url "https://api.openai.com/v1/images/generations"
  def create_image(api_key, file_name, prompt, bucket_name, save_fn) do
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{api_key}"}
    ]

    body = %{
      "model" => "dall-e-2",
      "prompt" => prompt,
      "n" => 1,
      "response_format" => "b64_json",
      "size" => "512x512"
    }

    response =
      Req.post!(@api_url,
        headers: headers,
        json: body
      )

    case response.status do
      200 ->
        image_data_base64 = response.body["data"] |> List.first() |> Map.get("b64_json")
        save_fn.(file_name, image_data_base64, bucket_name)

      _ ->
        IO.puts("Failed to generate image: #{response.status}")
        :error
    end
  end
end
