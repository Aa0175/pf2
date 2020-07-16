User.create!(
    {
      name:  "tester",
      email: "test@test.com",
      password:              "123456",
      password_confirmation: "123456"
    }
)

# user = User.find_by(id: 1)
# user.posts.create!(
#   {
#     title: "test1"
#   }
# )
#
# post = Post.find_by(id: 1)
# post.nodes.create!(
#   [
#     {
#       content: "hoge"
#     },
#     {
#       node_id: "1",
#       content: "あいうえお"
#     },
#     {
#       node_id: "2",
#       content: "中華麺"
#     }
#   ]
# )
