class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :friend_loundge]
  before_action :current_user_post
  before_action :friendship
  after_action :save_my_previous_url, only: [:new, :show, :loundge]



  def index
    @posts = Post.all
    @posts_not_mine = Post.where.not(owner_id: current_user.id)
    # @profile_check = current_user.posts
    #이걸로 하면, nil 인데도 index에서 nil로 인식을 안함. 왜?
    @profile_check = Post.find_by(owner_id: current_user.id)
    # @my_friend_request = Post.users_ids.where(id: current_user.id)
    # @my_friends = Post.where(post_id: Friend.where(post_id: current_user.id).select(:user_id), user_id: current_user.id)
    # @my_friends = Post.where(owner_id: Friend.where(user_id: Post.where(owner_id: current_user.post_ids).pluck(:owner_id), post_id: current_user.id).pluck(:user_id))
    @my_requests = Post.where(owner_id: Friend.where(user_id: current_user.id).pluck(:owner_id))
    @my_friends = Post.where(owner_id: Friend.where(owner_id: current_user.id, user_id: @my_requests.pluck(:owner_id)).pluck(:user_id))
    @my_requests_not_my_friends = @my_requests.where.not(id: @my_friends.pluck(:id))
    # Friend.where(user_id: current_user.owner_ids, owner_id: current_user.id).pluck(:user_id))
    @friend_requests = Post.where(owner_id: Friend.where(owner_id: current_user.id).pluck(:user_id)).where.not(id: @my_friends.pluck(:id))
    # @who_loves_my_friend = Heart.where()
    @love_request = Heart.where(host_id: current_user.id)
  end
  
  
  # def who_loves_my_friend(person)
  #   Post.where(owner_id: Heart.where(post_id: person.owner_id).pluck(:user_id))
  # end
  # helper_method :who_loves_my_friend
  
  def show
    @back_url = session[:my_previous_url]
  end
  
  def friend_loundge
    @back_url = session[:my_previous_url]
    @posts_not_mine = Post.where.not(owner_id: current_user.id)
    # @loundge_owner = User.find(@post.owner_id).post_ids.pluck(:owner_id)
    # @friendship = Friend.where(user_id: Post.where(owner_id: User.find(@post.owner_id).post_ids).pluck(:owner_id), post_id: @post.owner_id)
    # Friend.where(user_id: User.find(@post.owner_id).owner_ids, owner_id: @post.owner_id)
    @his_or_her_friends = Post.where(owner_id: @friendship.pluck(:user_id))
    @recommended_solos_not_my_sex = @his_or_her_friends.where.not(sex: @current_user_post.sex)
    @made_friends_not_my_sex = MakeFriend.where(friend_id: params[:id]).where.not(sex: @current_user_post.sex)
    # heart = Heart.find_by(user_id: current_user.id, post_id: params[:id])
    # if heart.nil?
    #   @loveletter = "이 사람을 소개시켜주세요!"
    #   byebug
    # else
    #   @loveletter = "소개 신청 취소"
    # end
  end
  
  def my_loundge
    # @my_friends = Post.where(owner_id: Friend.where(user_id: current_user.owner_ids, owner_id: current_user.id).pluck(:user_id))
    @my_friends = Post.where(owner_id: Friend.where(owner_id: current_user.id, user_id: Post.where(owner_id: Friend.where(user_id: current_user.id).pluck(:owner_id)).pluck(:owner_id)).pluck(:user_id))
    @current_user_made_up_friend = MakeFriend.where(friend_id: current_user.id) 
  end

  def lovers
    @love_request = Heart.where(lover_id: params[:lover_id])
  end


  def new
    @create_path = "#{current_user.id}/create"
    @empty_post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.owner_id = params[:id]
    @post.save
    
    redirect_to "/posts/#{@post.owner_id}"
  end

  def edit
    # @post = Post.find(params[:id])
    @update_path = "#{current_user.id}/update"
  end

  def update
    # @post = Post.find(params[:id])
    @current_user_post.update(post_params)
    @current_user_post.profilepics.attach(params[:profilepics])
    @current_user_post.save
    
    respond_to do |format|
      if @current_user_post.update(post_params)
        format.html { redirect_to "/posts/#{@current_user_post.owner_id}", notice: '프로필이 성공적으로 수정됐습니다.' }
      else
        format.html { render :edit }
      end
    end
      
    # redirect_to "/posts/#{@current_user_post.owner_id}"
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
    
    def current_user_post
      @current_user_post = Post.find_by(owner_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # 여기서 허용된 params들만 갖고올 수 있도록. 
    def post_params
      params.permit(:name, :profilepics, :sex, :age, :status, :home, :job, :workplace, :height, :selfintroduction, :comment, :owner_id, :religion, :smoking, :drink, :mind, :phone)
    end
    
    def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
    end
    
    def friendship
      #current_user와 친구인 사람의 아이디 = @friendship.pluck(:user_id)
      @friendship = Friend.where(owner_id: current_user.id, user_id: Post.where(owner_id: Friend.where(user_id: current_user.id).pluck(:owner_id)).pluck(:owner_id))
      @friend_id = @friendship.pluck(:user_id)
    end
end
