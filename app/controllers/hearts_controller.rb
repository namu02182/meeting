class HeartsController < ApplicationController
    def toggle_heart
        heart = Heart.find_by(user_id: current_user.id, post_id: params[:id])
        # if user_signed_in?
            if heart.nil?
                Heart.create(user_id: current_user.id, post_id: params[:id])
            else
                heart.destroy
            end
        
            
            
        redirect_to request.referrer
    end
    
end
