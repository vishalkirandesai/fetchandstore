
class StoreController < ApplicationController

  def bucketlist
    @track_uri = params[:track_uri]
    @buckets = AmazonUser.client.buckets
  end

  def store
    @track = current_user.soundcloud_client.get(params[:track_uri])
    @bucket = AmazonUser.client.buckets[params[:bucket_name]]
    if not @bucket.objects[@track.title].exists?
      object = @bucket.objects.create(@track.title,@track.uri)
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