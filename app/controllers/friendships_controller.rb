class FriendshipsController < ApplicationController
  #before_filter
  
  def index
    @friends = current_user.friends
    @pag_friends = current_user.friends.paginate(page: params[:page], per_page: 2)
    @pending_invited_by = current_user.pending_invited_by
    @pending_invited = current_user.pending_invited
  end
  
  def create
    @Friend = User.find(params[:id])
    @friendship_created = current_user.invite(@Friend)
    if @friendship_created
      flash[:notice] = "Friend invitation sent to #{@Friend.name}"
      redirect_to @Friend
    end
  end
    
  def update
    if params[:foo] == 'approve'
      @Friend = User.find(params[:id])
      @friendship_approved = current_user.approve(@Friend)
      flash[:notice] = "Approved request from #{@Friend.name}"
      redirect_to friendships_url
    elsif params[:foo] == 'decline'
      @Friend = User.find(params[:id])
      current_user.approve(@Friend)
      current_user.remove_friendship(@Friend)
      flash[:notice] = "Declined request from #{@Friend.name}"
      redirect_to friendships_url
    else 
    redirect_to friendships_url(params[:action])
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
  
