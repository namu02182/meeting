class HeartsController < ApplicationController
    def toggle_heart
        heart = Heart.find_by(user_id: current_user.id, lover_id: params[:lover_id])
            if heart.nil?
                Heart.create(user_id: current_user.id, lover_id: params[:lover_id], host_id: params[:host_id])
            else
                heart.destroy
            end
        redirect_to request.referrer
    end
    def toggle_heart2
        heart = Heart.find_by(user_id: current_user.id, lover_id: params[:lover_id])
            if heart.nil?
                Heart.create(user_id: current_user.id, lover_id: params[:lover_id], host_id: params[:host_id])
            else
                heart.destroy
            end
        redirect_to request.referrer
    end
    
end
