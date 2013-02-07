class MapsController < ApplicationController
  def show
    @action = params[:act]
    @post = Post.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
