class FriendshipsController < ApplicationController
  #before_filter
  
  def index
    @friends = current_user.friends
    @pag_friends = current_user.friends.paginate(page: params[:page], per_page: 25)
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
    @friend_id = params[:id]
    @Friend = User.find(@friend_id)
    @friendship_approved = current_user.approve(@Friend)
    if params[:foo] == 'decline'
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
    @Friend = User.find(params[:id])
    @friendship = current_user.send(:find_any_friendship_with, @Friend)
    if @friendship
      @friendship.delete
      @removed = true
      flash[:notice] = "Removed #{@Friend.name} from friends"
      redirect_to friendships_url
    end
  end
  
end
  
