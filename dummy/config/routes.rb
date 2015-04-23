Dummy::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  if Rails.version < '4.0.0'
    localized(I18n.available_locales) do
      scope "/:i18n_locale", :constraints => {:i18n_locale => /#{I18n.available_locales.join('|')}/} do 
        resources :contact, :only => [ :index ]
        Ecm::Cms::Routing.routes(self)
      end  
    end  
    match "/", :to => redirect("/#{I18n.locale}")    
  else
    localized do
      resources :contact, :only => [ :index ]
      Ecm::Cms::Routing.routes(self)
      root to: "ecm/cms/page#respond", :page => 'home' 
    end
    get "/", :to => redirect("/#{I18n.locale}")         
  end
end

