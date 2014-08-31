
class StoreController < ApplicationController

  def bucketlist
    @track_url = params[:track_url]
    @buckets = AmazonUser.getBuckets
  end

  def store(bucket)
    @track = current_user.soundcloud_client.get(@track_url)

    if not bucket.objects.contains(@track.title)
      object = bucket.object.create(@track.title,@track_url)
    end
    redirect_to you_bucket_list_path
  end

  def form

  end

  def create
    @bucket = AmazonUser.client.buckets.create(params[:bucket_name])
    store(@bucket)
  end
end