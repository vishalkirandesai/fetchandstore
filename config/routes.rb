FetchAndStore::Application.routes.draw do
  root :to => "fetch#index"

  match '/you',           :to => 'fetch#show',    :as => :you
  match '/you/update',    :to => 'fetch#update',  :as => :you_update

  match '/soundcloud/connect',    :to => 'soundcloud#connect',    :as => :soundcloud_connect
  match '/soundcloud/connected',  :to => 'soundcloud#connected',  :as => :soundcloud_connected
  match '/soundcloud/disconnect', :to => 'soundcloud#disconnect', :as => :soundcloud_disconnect
end
