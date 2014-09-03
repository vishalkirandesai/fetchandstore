FetchAndStore::Application.routes.draw do
  root :to => "fetch#index"

  match '/you',           :to => 'fetch#show',    :as => :you
  match '/you/update',    :to => 'fetch#update',  :as => :you_update
  match '/you/track/',    :to => 'fetch#view',    :as => :you_track_view

  match '/you/buckets', :to => 'store#bucketlist', :as => :you_bucket_list
  match '/you/buckets/store', :to =>'store#store', :as => :you_bucket_store
  match '/you/buckets/create', :to =>'store#create', :as => :you_bucket_create
  match '/you/buckets/create/form', :to =>'store#form', :as => :you_bucket_form

  match '/soundcloud/connect',    :to => 'soundcloud#connect',    :as => :soundcloud_connect
  match '/soundcloud/connected',  :to => 'soundcloud#connected',  :as => :soundcloud_connected
  match '/soundcloud/disconnect', :to => 'soundcloud#disconnect', :as => :soundcloud_disconnect
end
