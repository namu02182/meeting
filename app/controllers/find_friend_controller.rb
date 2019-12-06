class FindFriendController < ApplicationController
    def result
        @search_word = params[:search_word]
        @result = Post.where("name like ?", "%#{@search_word}%")
        @love_request = Heart.where(host_id: current_user.id)
        # +MakeFriend.where(name:  "%#{@search_word}%")
        #eval은 string을 ruby의 '모델'로 만들어준다
    end
end
