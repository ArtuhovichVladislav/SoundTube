API_KEY = 'AIzaSyAOziHAdhr38lpl75KX8Qkbh7eGtxyWfPw'
Yt.configure do |config|
  config.api_key = API_KEY
end

class VideoController < ApplicationController
	def new(channel_id = 'UCTj_JsfOlH4rHsREPkWxnzg')
		@channel = Yt::Channel.new id: channel_id
		@channel
	end 

	def video
		@channel = VideoController.new
		@playlists = @channel.playlists
		@items_collection = []
		@playlists.each do |playlist|
			@channel.get_playlist_videos(playlist.id).each do |item| 
				@items_collection.push(@channel.get_video_link(item.video_id))
			end
		end
		@items = Kaminari.paginate_array(@items_collection).page(params[:page]).per(5)
		puts @items 
		respond_to do |format|
			format.js
			format.html
		end
	end

	def playlists
		@channel = self.new
		@channel.playlists
	end

	def get_playlist_videos (playlist_id)
    playlist = Yt::Playlist.new id: playlist_id
    playlist.playlist_items
	end

	def get_video_link (video_id)
		video_id 
	end
end



