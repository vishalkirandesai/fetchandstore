class FetchController < ApplicationController
  def index
  end

  def show
    @tracks = current_user.soundcloud_client.get("/me/tracks", :limit => 5)
    @me     = current_user.soundcloud_client.get("/me")
  end

  def update
    res = current_user.soundcloud_client.put("/me", :user => {:description => params[:description]})
    redirect_to :action => :show
  end

  def view
    @track = current_user.soundcloud_client.get(params[:track_uri])
  end
end