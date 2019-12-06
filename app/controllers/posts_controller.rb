class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :friend_loundge, :edit_profilepics]
  before_action :current_user_post
  # before_action :friendship
  after_action :save_my_previous_url, only: [:new, :show, :loundge, :update_profilepics]



  def index
    @posts = Post.all
    @posts_not_mine = Post.where.not(owner_id: current_user.id)
    @profile_check = Post.find_by(owner_id: current_user.id)
    @my_requests = Post.where(owner_id: Friend.where(user_id: current_user.id).pluck(:owner_id))
    # @my_friends = Post.where(owner_id: Friend.where(owner_id: current_user.id, user_id: @my_requests.pluck(:owner_id)).pluck(:user_id))
    @my_friends = Post.where(owner_id: friend_list(current_user.id))
    @my_requests_not_my_friends = @my_requests.where.not(id: @my_friends.pluck(:id))
    # Friend.where(user_id: current_user.owner_ids, owner_id: current_user.id).pluck(:user_id))
    @friend_requests = Post.where(owner_id: Friend.where(owner_id: current_user.id).pluck(:user_id)).where.not(id: @my_friends.pluck(:id))
    @love_request = Heart.where(host_id: current_user.id)
    @recommended_solos = Post.where(owner_id: friend_list(@my_friends.pluck(:owner_id))).where.not(sex: @current_user_post.sex).where(status: "솔로")
    @recommended_solos_not_my_friend = @recommended_solos.where.not(owner_id: @my_friends.pluck(:owner_id))
  end
  
  
  def show
    @back_url = request.referer
  end
  
  def friend_loundge
    @back_url = request.referer
    @his_or_her_friends = Post.where(owner_id: friend_list(params[:id]))
    @recommended_solos_not_my_sex = @his_or_her_friends.where.not(sex: @current_user_post.sex)
    @made_friends_not_my_sex = MakeFriend.where(friend_id: params[:id]).where.not(sex: @current_user_post.sex)

  end
  
  def my_loundge
    # @my_friends = Post.where(owner_id: Friend.where(user_id: current_user.owner_ids, owner_id: current_user.id).pluck(:user_id))
    @my_friends = Post.where(owner_id: friend_list(current_user.id))
    @current_user_made_up_friend = MakeFriend.where(friend_id: current_user.id) 
  end
  
  def my_friend_list 
        @my_friends = Post.where(owner_id: friend_list(current_user.id))
            @my_requests = Post.where(owner_id: Friend.where(user_id: current_user.id).pluck(:owner_id))
            @my_requests_not_my_friends = @my_requests.where.not(id: @my_friends.pluck(:id))
                @friend_requests = Post.where(owner_id: Friend.where(owner_id: current_user.id).pluck(:user_id)).where.not(id: @my_friends.pluck(:id))
  end

  def lovers
    @love_request = Heart.where(lover_id: params[:lover_id])
  end

  def my_lovers
    @my_love_request = Heart.where(user_id: current_user.id)
    @friend_love_request = Heart.where(host_id: current_user.id)
  end


  def new
    @create_path = "#{current_user.id}/create"
    @empty_post = Post.new
    @after_profilepics = Post.find_by(owner_id: current_user.id)
  end

  def create
    @post = Post.find_by(owner_id: current_user.id).update(post_params)

    
    redirect_to "/posts/#{params[:id]}"
  end
  
  def edit
    # @post = Post.find(params[:id])
    @update_path = "#{current_user.id}/update"
    
    if @current_user_post.name.nil?
      @submit_text = "프로필 등록하기"
      else
      @submit_text = "프로필 수정하기"
    end
  end

  def update
    # @post = Post.find(params[:id])
    @current_user_post.update(post_params)
    # @current_user_post.profilepics.attach(params[:post][:profilepics])
    # @current_user_post.save
    
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
  
  def new_profilepics
    @post = Post.new
  end
  
  def create_profilepics
    @post = Post.create(params.require(:post).permit(:profilepics))
    @post.owner_id = params[:id]
    @post.save
    # profilepics_params = params[:post].permit(profilepics: [])
    # @post = Post.find_by(owner_id: params[:id])
    # @post.profilepics = params.require(:post).permit(:profilepics)
    # @post.save
    # byebug
    # redirect_to "/posts/#{@post.owner_id}"
    redirect_to "/posts/#{current_user.id}/edit"
  end
  
  def edit_profilepics
    @back_url_for_edit_profilepics = request.referer

  end

  def update_profilepics
    @post = Post.find_by(owner_id: params[:id]).update(params.require(:post).permit(:profilepics))
    redirect_to params[:url].to_s
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
    
    def friend_list(personid)
      return Friend.where(owner_id: personid, user_id: Friend.where(user_id: personid).pluck(:owner_id)).pluck(:user_id)
    end
    helper_method :friend_list
end
