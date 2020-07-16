json.post_name @post.post_name
json.array do
  json.array! @post.nodes, :node_name, :id
end
