module Ecm
  module Cms
    class Routing
      def self.routes(router, options = {})
        options.reverse_merge!({})
        if Rails.version < '4.0.0' 
          router.match "/*page", :to => "ecm/cms/page#respond", :as => :page
          router.match '/' => "ecm/cms/page#respond", :page => 'home', :as => :root
        else
          router.get "/*page", :to => "ecm/cms/page#respond", :as => :page
          router.get '/' => "ecm/cms/page#respond", :page => 'home', :as => :root
        end
      end
    end
  end
end

