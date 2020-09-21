# User.create!(
#     {
#       name:  "tester",
#       email: "test@test.com",
#       password:              "123456",
#       password_confirmation: "123456"
#     }
# )

#ユーザーの属性
# Sex.create!(
#   [
#     { sex:  "-" },
#     { sex:  "男" },
#     { sex:  "女" },
#     { sex:  "その他" }
#   ]
# )

# Birthplace.create!(
#   [
#     { birthplace: "-" },
#     { birthplace: "北海道" },
#     { birthplace: "東北" },
#     { birthplace: "関東" },
#     { birthplace: "中部" },
#     { birthplace: "関西" },
#     { birthplace: "中国" },
#     { birthplace: "四国" },
#     { birthplace: "九州" },
#     { birthplace: "沖縄" },
#     { birthplace: "その他" }
#   ]
# )
#
# Residence.create!(
#   [
#     { residence: "-" },
#     { residence: "北海道" },
#     { residence: "東北" },
#     { residence: "関東" },
#     { residence: "中部" },
#     { residence: "関西" },
#     { residence: "中国" },
#     { residence: "四国" },
#     { residence: "九州" },
#     { residence: "沖縄" },
#     { residence: "その他" }
#   ]
# )
#
# Housemate.create!(
#   [
#     { housemate: "-" },
#     { housemate: "一人暮らし" },
#     { housemate: "実家暮らし" },
#     { housemate: "兄弟姉妹" },
#     { housemate: "友達" },
#     { housemate: "ペット" },
#     { housemate: "その他" }
#   ]
# )

# user = User.find_by(id: 1)
# user.posts.create!(
#   {
#     title: "seed test 1"
#   }
# )
#
#こっから下アウト★



# Node.create!(
#     {
#       post_id: "1",
#       content: "幼女がいたらどうする？"
#     },
#     {
#       post_id: "1",
#       content: "逃げる",
#       parent_id
#     },
# )

#------------------------------------------------------以下遺物

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
