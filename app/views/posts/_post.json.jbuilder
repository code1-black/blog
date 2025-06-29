json.extract! post, :id, :title, :body, :images, :created_at, :updated_at
json.url post_url(post, format: :json)
json.body post.body.to_s
json.images do
  json.array!(post.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
