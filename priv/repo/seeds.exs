# Add dummy branding for dev
Forge.saved_branding(
  item: "headline", 
  copy: "I’m Brian Gamble, and my passions are <mark>tested, simple, and clear code</mark>, and <mark>inviting, minimalistic design</mark>."
)
Forge.saved_branding(item: "intro", copy: Enum.join(Faker.Lorem.paragraphs(2..4), "\n\n"))
Forge.saved_branding(item: "bio", copy: Enum.join(Faker.Lorem.sentences(3..5), "\n"))
Forge.saved_branding(item: "colophon", copy: Enum.join(Faker.Lorem.sentences(2..4), "\n"))
