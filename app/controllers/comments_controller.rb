class CommentsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy

  def index
  end
  
  def create
    @comment = current_user.comments.build(params[:comment])
    @post_ = Post.find_by_id(params[:comment][:post_id])
    @post = current_user.posts.build
    if @comment.user == current_user
      if @comment.save
        respond_to do |format|
          format.html {redirect_to root_url}
          format.js
      end
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
        #render 'static_pages/home'
      end
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end
  
  private
  
    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_url if @comment.nil?
    end

end
