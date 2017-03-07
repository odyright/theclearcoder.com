defmodule Blog.Services.ChallengeService do
  def get_response(content) do
    values = get_app_values()

    if values[:state] == "ON" do
      "#{content}#{values[:response]}"
    else
      ""
    end
  end

  defp get_app_values(),  do: Application.get_env(:blog, :lets_encrypt)
end
