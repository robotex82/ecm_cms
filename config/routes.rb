Ecm::Cms::Engine.routes.draw do
  get "/*page", :to => "ecm/cms/page#respond", :as => :page
  get '/' => "ecm/cms/page#respond", :page => 'home', :as => :root
end
