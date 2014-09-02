 require 'yaml'
 require 'open_uri_redirections'

class StoreController < ApplicationController

  def bucketlist
    @track_url = params[:track_url]
    @buckets = AmazonUser.client.buckets
  end

  def store
    @track = current_user.soundcloud_client.get('/resolve', :url => params[:track_url],:client_id => current_user.get_client_id)
    track_title = @track.title
    track_filename = "%s.aif" % track_title.to_s
    download_url = "%s?client_id=%s" % [@track.download_url,current_user.get_client_id.to_s]
    @bucket = AmazonUser.client.buckets[params[:bucket_name]]
    if not @bucket.objects[track_filename].exists?
      object = @bucket.objects.create(track_filename,"")
      open(download_url, allow_redirections: :all) do |read_file|
        object.write(read_file.read)
      end
      @stored = true
    else
      @stored = false
    end
  end

  def form

  end

  def create
    @bucket = AmazonUser.client.buckets.create(params[:bucket_name])
    redirect_to you_bucket_list_path
  end
end