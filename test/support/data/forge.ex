defmodule Forge do
  use Blacksmith
  alias Blog.{User, Article, Branding, Podcast}

  @save_one_function &Blacksmith.Config.save/1
  @save_all_function &Blacksmith.Config.save_all/1

  register :article, %Article{
    slug:    Faker.Lorem.characters(5..10) |> List.to_string |> String.downcase,
    title:   Faker.Lorem.sentence(),
    teaser:  Faker.Lorem.sentence(),
    content: Enum.join(Faker.Lorem.sentences(), "\n")
  }

  register :branding, %Branding{
    item: "heading", 
    copy: Faker.Lorem.sentence()
  }

  register :podcast, %Podcast{
    episode:          1,
    title:            Faker.Lorem.sentence(),
    description:      Faker.Lorem.sentence(),
    file_url:         "#{Faker.Internet.url()}/#{Faker.Lorem.word()}.mp3",
    file_size_mbytes: 7,
    run_time_minutes: 15
  }

  register :user, %User{
    name:     Faker.Name.name(),
    username: Faker.Internet.user_name()
  }
end
