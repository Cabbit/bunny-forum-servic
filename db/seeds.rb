def generate_title(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

1000.times do
  title = generate_title(rand(1..20))
  p "Create #{title}"
  Post.create! title: title
end
