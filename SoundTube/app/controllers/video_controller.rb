API_KEY = 'AIzaSyAOziHAdhr38lpl75KX8Qkbh7eGtxyWfPw'
Yt.configure do |config|
  config.api_key = API_KEY
end

class VideoController < ApplicationController

  def show
    @channel = Yt::Channel.new id: params[:id]
		@playlists = @channel.playlists
		@items_collection = []
    c = 0
		@playlists.each do |playlist|
      break if c > 1
      c += 1
			get_playlist_videos(playlist.id).each do |item|
				@items_collection.push item.video_id
        print item.video_id
			end
		end
		@items = Kaminari.paginate_array(@items_collection).page(params[:page]).per(20)
		puts @items
		respond_to do |format|
			format.js
			format.html
		end
  end

	def get_playlist_videos (playlist_id)
    playlist = Yt::Playlist.new id: playlist_id
    playlist.playlist_items
	end

end
