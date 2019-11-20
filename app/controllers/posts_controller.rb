class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :loundge]
  after_action :save_my_previous_url, only: [:new, :show, :loundge]



  def index
    @posts = Post.all
    @posts_not_mine = Post.where.not(owner_id: current_user.id)
    # @profile_check = current_user.posts
    #이걸로 하면, nil 인데도 index에서 nil로 인식을 안함. 왜?
    @profile_check = Post.find_by(owner_id: current_user.id)
    # @my_friend_request = Post.users_ids.where(id: current_user.id)
    # @my_friends = Post.where(post_id: Friend.where(post_id: current_user.id).select(:user_id), user_id: current_user.id)
    @my_friends = Post.where(owner_id: Friend.where(user_id: Post.where(owner_id: current_user.post_ids).pluck(:owner_id), post_id: current_user.id).pluck(:user_id))
    @my_requests = Post.where(owner_id: current_user.post_ids).where.not(id: @my_friends.pluck(:id))
    @friend_requests = Post.where(owner_id: Friend.where(post_id: current_user.id).pluck(:user_id)).where.not(id: @my_friends.pluck(:id))
  end

  def show
    @back_url = session[:my_previous_url]
  end
  
  def loundge
    @back_url = session[:my_previous_url]
    @posts_not_mine = Post.where.not(owner_id: current_user.id)
    # @loundge_owner = User.find(@post.owner_id).post_ids.pluck(:owner_id)
    @friendship = Friend.where(user_id: Post.where(owner_id: User.find(@post.owner_id).post_ids).pluck(:owner_id), post_id: @post.owner_id)
    @his_or_her_friends = Post.where(owner_id: @friendship.pluck(:user_id))
    @recommended_solos_not_my_sex = @his_or_her_friends.where.not(sex: Post.find_by(owner_id: current_user).sex)
  end

  def new
    @save_path = "/posts/create"
  end

  def create
    @post = Post.create(post_params)
    @post.owner_id = params[:id]
    
    redirect_to "/posts/#{@post.owner_id}/show"
  end

  def edit
    # @post = Post.find(params[:id])
    @edit_path = "/posts/update"
  end

  def update
    # @post = Post.find(params[:id])
    @post.update(post_params)
      
    redirect_to "/posts/#{@post.owner_id}/show"
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    
    redirect_back(fallback_location: root_path)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(owner_id: params[:id])
      #post의 params[:id]는 current_user.id이며, owner_id로 넘어옵니다.
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # 여기서 허용된 params들만 갖고올 수 있도록. 
    def post_params
      params.permit(:name, :id, :sex, :age, :status, :home, :job, :workplace, :height, :selfintroduction, :religion, :smoking, :drink, :mind, :phone)
    end
    
    def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
    end
end
