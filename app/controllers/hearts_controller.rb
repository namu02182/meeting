class HeartsController < ApplicationController
    def toggle_heart
        heart = Heart.find_by(user_id: current_user.id, post_id: params[:lover_id])
            if heart.nil?
                Heart.create(user_id: current_user.id, post_id: params[:lover_id], email_id: params[:friend_email])
            else
                heart.destroy
            end
        redirect_to request.referrer
    end
    
end
