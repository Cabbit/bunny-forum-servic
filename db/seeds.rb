def generate_text(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

10.times do
  title = generate_text(rand(5..20))

  p "Create category #{title}"
  Category.create! title: title
end

Category.find_each do |category|
  rand(1..10).times do
    title = generate_text(rand(5..20))
    description = generate_text(rand(5..20))

    p "Create forum #{title} for category #{category.title}"
    Forum.create! title: title, description: description, category_id: category.id
  end
end

Forum.find_each do |forum|
  rand(1..10).times do
    title = generate_text(rand(5..20))

    p "Create topic #{title} for forum #{forum.title}"
    Topic.create! title: title, forum_id: forum.id
  end
end

Topic.find_each do |topic|
  rand(1..20).times do
    title = generate_text(rand(5..20))

    p "Create post #{title} for topic #{topic.title}"
    Post.create! title: title, topic_id: topic.id
  end
end
