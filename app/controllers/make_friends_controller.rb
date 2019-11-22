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
    @made_friends.user_id = current_user.id
    @make_friends.save
    
    redirect_to "/posts/#{current_user.id}/make_friends/#{@made_friends.id}"
  end
  def edit
    # @post = Post.find(params[:id])
    @update_path = "#{current_user.id}/update"
  end

  def update
    # @post = Post.find(params[:id])
    @current_user_post.update(post_params)
    respond_to do |format|
      if @current_user_post.update(post_params)
        format.html { redirect_to "/posts/#{@current_user_post.owner_id}", notice: '프로필이 성공적으로 수정됐습니다.' }
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
      params.permit(:name, :id, :sex, :age, :home, :job, :workplace, :height, :selfintroduction,  :comment, :religion, :smoking, :drink, :mind, :phone, :user_id)
    end
    
    def current_user_made_up_friend
      @current_user_made_up_friend = current_user.make_friends.all
    end
    
    def set_made_friends
      @made_friend = current_user.make_friends.find(params[:id])
      #post의 params[:id]는 current_user.id이며, owner_id로 넘어옵니다.
    end
  
end
