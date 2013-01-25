class FriendshipsController < ApplicationController
  #before_filter
  
  def show
  end
  
  def index
    @friends = current_user.friends
    @pag_friends = current_user.friends.paginate(page: params[:page], per_page: 3)
    @pending_invited_by = current_user.pending_invited_by
    @pending_invited = current_user.pending_invited
  end
  
  def create
    @Friend = User.find(params[:id])
    @friendship_created = current_user.invite(@Friend)
    @pending_invited_by = current_user.pending_invited_by
    if @friendship_created
      flash[:notice] = "Friend invitation sent to #{@Friend.name}"
      redirect_to @Friend
    end
  end
    
  def update
    @update_param = params[:foo]
    @pag_friends = current_user.friends.paginate(page: params[:page], per_page: 3)
    @friends = current_user.friends
    @friend_id = params[:id]
    @Friend = User.find(@friend_id)
    @friendship_approved = current_user.approve(@Friend)
    if @update_param == 'decline'
      #Can't do anything about this, this is how you decline
      current_user.remove_friendship(@Friend)
    end
    @pending_invited_by = current_user.pending_invited_by #pending array
    respond_to do |format|
      format.html {redirect_to friendships_url}
      format.js
    end
  end
  
  def destroy
    @friends = current_user.friends
    #@page_path = /(.*?)\d*$/.match(params[:page])[1]
    @pag_friends = current_user.friends.paginate(page: params[:page], per_page: 3)
    @Friend = User.find(params[:id])
    @friendship = current_user.send(:find_any_friendship_with, @Friend)
    if @friendship
      @friendship.delete
      @removed = true
      respond_to do |format|
        format.html {redirect_to friendships_url}
        format.js
      end
    end
  end
  
end
  
