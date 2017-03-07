defmodule Blog.Services.ChallengeServiceTest do
  use ExUnit.Case, async: false
  alias Blog.Services.ChallengeService

  test "returns an empty string when off" do
    # turn off challenge response
    values = Application.get_env(:blog, :lets_encrypt)
    Application.put_env(:blog, :lets_encrypt, state: "OFF")

    assert ChallengeService.get_response("foobar") == ""
    
    # restore challenge response
    Application.put_env(:blog, :lets_encrypt, values)
  end

  test "prepends the content to let's encrypt response" do
    assert ChallengeService.get_response("foobar") == "foobar1234567890abcdef"
  end
end
