# Clear out existing data
Blog.Repo.delete_all(Blog.Branding)
Blog.Repo.delete_all(Blog.Writing.Article)

# Add dummy branding for dev
Forge.saved_branding(
  item: "headline", 
  copy: "I’m Brian Gamble, and my passions are <mark>tested, simple, and clear code</mark>, and <mark>inviting, minimalistic design</mark>."
)
Forge.saved_branding(item: "intro", copy: Enum.join(Faker.Lorem.paragraphs(2..4), "\n\n"))
Forge.saved_branding(item: "bio", copy: Enum.join(Faker.Lorem.sentences(3..5), "\n"))
Forge.saved_branding(item: "colophon", copy: Enum.join(Faker.Lorem.sentences(2..4), "\n"))

# Add 15 dummy articles from the past 90 days
days = Enum.map(1..15, fn(_) -> Enum.random(1..90) end)
for n <- days do
  Forge.saved_article(inserted_at: Timepiece.days_ago(n))
end
