class FetchController < ApplicationController
  def index
  end

  def show
    @tracks = current_user.soundcloud_client.get("/me/tracks", :limit => 5)
    @me     = current_user.soundcloud_client.get("/me")
  end

  def view
    #@track = current_user.soundcloud_client.get(params[:track_uri])
    @track = current_user.soundcloud_client.get('/resolve', :url => params[:track_url],:client_id=>current_user.get_client_id)
  end
end