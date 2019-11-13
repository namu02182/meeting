# 기존 사용자 삭제 & 기존 좋아요 삭제
User.destroy_all

# 더미 사용자 생성
user_1 = User.create(email: "1@1.com", password: "123123", password_confirmation: "123123")
user_2 = User.create(email: "2@2.com", password: "123123", password_confirmation: "123123")
user_3 = User.create(email: "3@3.com", password: "123123", password_confirmation: "123123")
user_4 = User.create(email: "4@4.com", password: "123123", password_confirmation: "123123")
user_5 = User.create(email: "5@5.com", password: "123123", password_confirmation: "123123")
user_6 = User.create(email: "6@6.com", password: "123123", password_confirmation: "123123")
user_7 = User.create(email: "7@7.com", password: "123123", password_confirmation: "123123")
user_8 = User.create(email: "8@8.com", password: "123123", password_confirmation: "123123")
user_9 = User.create(email: "9@9.com", password: "123123", password_confirmation: "123123")
user_10 = User.create(email: "10@10.com", password: "123123", password_confirmation: "123123")

# 기존 글 삭제
Post.destroy_all

# 더미 글 생성 & 더미 댓글 생성
post_1 = Post.create(name: "남자2호", owner_id: "9", sex: "male", content: "안녕하세요")
post_2 = Post.create(name: "남자1호", owner_id: "8", sex: "male", content: "굿모닝하세요")
post_3 = Post.create(name: "여자2호", owner_id: "7", sex: "female", content: "굿나잇하세요")
post_4 = Post.create(name: "여자1호", owner_id: "6", sex: "female", content: "잘하세요")
post_5 = Post.create(name: "여자3호", owner_id: "4", sex: "female", content: "잘 좀 하세요")
post_6 = Post.create(name: "여자4호", owner_id: "3", sex: "female", content: "안녕히계세요")
post_7 = Post.create(name: "남자5호", owner_id: "2", sex: "male", content: "저는보라카이갑니다")
post_8 = Post.create(name: "남자6호", owner_id: "1", sex: "male", content: "코딩재밌다")

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
#5번하고 10번은 프로필 등록 안 했음
user_1.friends.create(post: post_1)
user_2.friends.create(post: post_1)
user_3.friends.create(post: post_2)
user_4.friends.create(post: post_3)
user_5.friends.create(post: post_4)
user_6.friends.create(post: post_5)
user_7.friends.create(post: post_6)
user_8.friends.create(post: post_7)
user_3.friends.create(post: post_8)
user_5.friends.create(post: post_1)
user_7.friends.create(post: post_2)
user_9.friends.create(post: post_3)
user_1.friends.create(post: post_4)
user_2.friends.create(post: post_5)
user_5.friends.create(post: post_6)
user_6.friends.create(post: post_7)
user_7.friends.create(post: post_8)
user_1.friends.create(post: post_1)
user_2.friends.create(post: post_2)
user_3.friends.create(post: post_3)
user_4.friends.create(post: post_4)
user_5.friends.create(post: post_5)
user_6.friends.create(post: post_6)
user_7.friends.create(post: post_7)
user_8.friends.create(post: post_8)
user_9.friends.create(post: post_1)
user_3.friends.create(post: post_2)
user_4.friends.create(post: post_3)
user_5.friends.create(post: post_4)
user_7.friends.create(post: post_5)
user_8.friends.create(post: post_6)
user_2.friends.create(post: post_7)
user_3.friends.create(post: post_8)
