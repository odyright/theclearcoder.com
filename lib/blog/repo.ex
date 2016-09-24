defmodule Blog.Repo do
  @moduledoc """
  In-memory repository.
  """

  def all(Blog.Article) do
    [
      %Blog.Article{
        id: "1", slug: "new-beginnings", title: "New beginnings",
        teaser: """
        After two decades in software development, I have an exciting announcement about the next step in my career.
        """,
        content: """
        For the past twenty years, I've been building software apps for a variety of
        different companies, and during that time I've maintained a dream of starting
        my own company.  I've come close a few times, but for one reason or another the
        timing wasn't right.

        As of July, my dream is now a reality.  I would like to introduce my new company, 
        [Gentle Lion Studios](http://www.gentlelionstudios.com).

        I'm extremely excited, and I hope you'll come along for the ride.
        """
      }
    ] 
  end

  def all(_module), do: []

  def get_by(module, params) do Enum.find all(module), fn map ->
    Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end) end
  end
end
