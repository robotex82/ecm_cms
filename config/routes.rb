Ecm::Cms::Engine.routes.draw do
#  if Rails.version < '4.0.0'
#    get "/*page", :to => "ecm/cms/page#respond", :as => :page
#  else
#    localized do
#      get "/*page", :to => "ecm/cms/page#respond", :as => :page
#      # get "/:page", :to => "ecm/cms/page#respond", page: /.*/, :as => :page
#    end
#  end

##  root to: "ecm/cms/page#respond", :page => 'home' 
#  # get '/' => "ecm/cms/page#respond", :page => 'home', :as => :'main_app.root'
end
