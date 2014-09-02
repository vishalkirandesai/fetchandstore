require 'yaml'

class User < ActiveRecord::Base
  # With great help from -> http://soundcloud.com/you/apps/connect-with-soundcloud-rails-demo
  @credentials = YAML.load_file('./config/credentials.yml')

  SOUNDCLOUD_CLIENT_ID     = @credentials['soundcloud']['client_id']
  SOUNDCLOUD_CLIENT_SECRET = @credentials['soundcloud']['client_secret']

  attr_accessible :soundcloud_access_token, :soundcloud_expires_at, :soundcloud_refresh_token, :soundcloud_user_id, :soundcloud_username, :photo_attributes

  def self.soundcloud_client(options={})
    options = {
      :client_id     => SOUNDCLOUD_CLIENT_ID,
      :client_secret => SOUNDCLOUD_CLIENT_SECRET,
    }.merge(options)

    Soundcloud.new(options)
  end
  
  
  def soundcloud_client(options={})
    options= {
      :expires_at    => soundcloud_expires_at,
      :access_token  => soundcloud_access_token,
      :refresh_token => soundcloud_refresh_token
    }.merge(options)
    
    client = self.class.soundcloud_client(options)
    
    # define a callback for successful token exchanges
    # this will make sure that new access_tokens are persisted once an existing 
    # access_token expired and a new one was retrieved from the soundcloud api
    client.on_exchange_token do
      self.update_attributes!({
        :soundcloud_access_token  => client.access_token,
        :soundcloud_refresh_token => client.refresh_token,
        :soundcloud_expires_at    => client.expires_at,
      })
    end
    
    client
  end

  def get_client_id
    SOUNDCLOUD_CLIENT_ID
  end
end
