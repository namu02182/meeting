class FriendsController < ApplicationController
    def become_friends
        friend = Friend.find_by(user_id: current_user.id, owner_id: params[:owner_id])
        if friend.nil?
            Friend.new(user_id: current_user.id, owner_id: params[:owner_id]).save!
        else
            friend.destroy
        end
        redirect_to '/'
    end
end
