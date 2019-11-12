# 기존 사용자 삭제 & 기존 좋아요 삭제
User.destroy_all

# 더미 사용자 생성
user_1 = User.create(email: "1@1.com", password: "111111", password_confirmation: "111111")
user_2 = User.create(email: "2@2.com", password: "111111", password_confirmation: "111111")
user_3 = User.create(email: "3@3.com", password: "111111", password_confirmation: "111111")
user_4 = User.create(email: "4@4.com", password: "111111", password_confirmation: "111111")
user_5 = User.create(email: "5@5.com", password: "111111", password_confirmation: "111111")

# 기존 글 삭제
Post.destroy_all

# 더미 글 생성 & 더미 댓글 생성
post_1 = Post.create(name: "남자2호", owner_id: "2", sex: "male", content: "안녕하세요")
post_2 = Post.create(name: "남자1호", owner_id: "1", sex: "male", content: "굿모닝하세요")
post_3 = Post.create(name: "여자2호", owner_id: "4", sex: "female", content: "굿나잇하세요")
post_4 = Post.create(name: "여자1호", owner_id: "3", sex: "female", content: "잘하세요")

# post_1.comments.create(body: "네 안녕하세요!")
# post_1.comments.create(body: "저는 별로...")

# post_2 = Post.create(title: "worklion", content: "B반")
# post_2.comments.create(body: "와아!!!")
# post_2.comments.create(body: "화이팅!!!")

# 더미 좋아요 생성
# user_1.likes.create(post: post_1)
# user_2.likes.create(post: post_1)
# user_1.likes.create(post: post_2)
# user_2.likes.create(post: post_2)
# user_3.likes.create(post: post_2)

# # 더미 친구요청들 생성
# user_1.friends.create(post: post_2)
# user_1.friends.create(post: post_3)
# user_1.friends.create(post: post_4)
# user_2.friends.create(post: post_4)
# user_2.friends.create(post: post_1)
# user_2.friends.create(post: post_3)
# user_3.friends.create(post: post_2)
# user_4.friends.create(post: post_1)
# user_4.friends.create(post: post_2)
