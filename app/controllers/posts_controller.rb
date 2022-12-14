class PostsController < ApplicationController
  def index
    @current_user = current_user
    @posts_per_page = 2
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 1)
    # rawposts = @user.posts.includes(:comments)
    # @posts = rawposts[2 * (@page.to_i - 1), @posts_per_page]
  end

  def show
    @current_user = current_user
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = current_user
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.new
    post.title = params[:user_posts][:title]
    post.text = params[:user_posts][:text]
    post.author = current_user
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post was successfully created'
          redirect_to user_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, new_user_post_path(current_user)
        end
      end
    end
  end
end
