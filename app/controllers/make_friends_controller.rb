class MakeFriendsController < ApplicationController
  after_action :save_my_previous_url
  before_action :current_user_made_up_friend
  before_action :set_made_friends, only: [:show, :edit, :update, :destroy]
  
  def index
  end
    
  def new
    @create_path = ""
    @empty_post = MakeFriend.new
    @back_url = session[:my_previous_url]
  end
  
  def show
    @back_url = session[:my_previous_url]
  end

  def create
    @made_friends = MakeFriend.create(make_friends_params)
    # @made_friends_easy = MakeFriend.new
    # @made_friends_easy.name = params[:make_friend][:name]
    # @made_friends_easy.selfintroduction = params[:make_friend][:selfintroduction]
    # @made_friends_easy.user_id = params[:owner_id]
    # @made_friends_easy.save!
    # @make_friends.save
    redirect_to "/posts/my_loundge/#{current_user.id}"
  end
  def edit
    # @post = Post.find(params[:id])
    @update_path = params[:id]
  end

  def update
    # @post = Post.find(params[:id])
    @this_friend = MakeFriend.find_by(id: params[:id], owner_id: current_user.id)
    @this_friend.update(make_friends_params)
    respond_to do |format|
      if @this_friend.update(make_friends_params)
        format.html { redirect_to "/posts/#{current_user.id}/make_friends/#{params[:id]}", notice: '친구 프로필이 성공적으로 수정됐습니다.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
    def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
    end
    def make_friends_params
      params.permit(:name, :owner_id, :sex, :age, :home, :job, :workplace,
          :height, :selfintroduction,  :comment, :religion, :smoking, :drink, :mind, :phone, make_friend: [:id, :name, :selfintroduction])
    end
    
    def current_user_made_up_friend
      @current_user_made_up_friend = current_user.make_friends.all
    end
    
    def set_made_friends
      @made_friend = current_user.make_friends.find(params[:id])
      #post의 params[:id]는 current_user.id이며, owner_id로 넘어옵니다.
    end
  
end
