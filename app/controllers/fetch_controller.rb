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
    @track_url = params[:t_url]
    @embed_info = current_user.soundcloud_client.get('/oembed', :url => @track_url,:iframe => "false")
  end
end