API_KEY = 'AIzaSyAOziHAdhr38lpl75KX8Qkbh7eGtxyWfPw'
Yt.configure do |config|
  config.api_key = API_KEY
  config.log_level = :debug
end

class ExploreController < ApplicationController
  def index
    @playlist = Yt::Playlist.new id: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI'
    @items_collection = []
		@playlist.playlist_items.each do |item|
				@items_collection.push item.video_id
		end

		@items = Kaminari.paginate_array(@items_collection).page(params[:page]).per(20)
		respond_to do |format|
			format.js
			format.html
		end
  end
end
