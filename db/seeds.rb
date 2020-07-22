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
#     title: "seed test 1"
#   }
# )
#
# post = Post.find_by(id: 1)
# post.questions.create!(
#     {
#       post_id: "1",
#       content: "seed question 1"
#     }
# )

#こっから下アウト★



# question1 = Question.find_by(id: 1)
# question1.answers.create!(
#   [
#     {
#       question_id: "1",
#       content: "answer 1"
#     },
#     {
#       question_id: "1",
#       content: "answer 2"
#     }
#   ]
# )
#
# answer1 = Answer.find_by(id: 1)
# answer1.questions.create!(
#   [
#     {
#       answer_id: "1",
#       content: "question 2"
#     }
#   ]
# )
#
# question2 = Question.find_by(id: 2)
# question2.answers.create!(
#   [
#     {
#       question_id: "2",
#       content: "answer 3"
#     },
#     {
#       question_id: "2",
#       content: "answer 4"
#     }
#   ]
# )
#
# answer2 = Answer.find_by(id: 2)
# answer2.questions.create!(
#   [
#     {
#       answer_id: "2",
#       content: "queston 3"
#     }
#   ]
# )
#
# question3 = Question.find_by(id: 3)
# question3.answers.create!(
#   [
#     {
#       question_id: "3",
#       content: "answer 5"
#     },
#     {
#       question_id: "3",
#       content: "answer 6"
#     }
#   ]
# )
