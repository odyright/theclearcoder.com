defmodule Forge do
  use Blacksmith
  alias Blog.User
  alias Blog.Article
  alias Blog.Branding

  @save_one_function &Blacksmith.Config.save/1
  @save_all_function &Blacksmith.Config.save_all/1

  register :user, %User{
    name: Faker.Name.name(),
    username: Faker.Internet.user_name()
  }

  register :article, %Article{
    slug: Faker.Lorem.characters(5..10) |> List.to_string |> String.downcase,
    title: Faker.Lorem.sentence(),
    teaser: Faker.Lorem.sentence(),
    content: Enum.join(Faker.Lorem.sentences(), "\n")
  }

  register :branding, %Branding{
    item: "heading", 
    copy: Faker.Lorem.sentence()
  }
end
