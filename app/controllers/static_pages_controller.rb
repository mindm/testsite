class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    @ip = request.remote_ip
    @location = GeoKit::Geocoders::GeoPluginGeocoder.geocode(@ip)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def destroy
  end
end
