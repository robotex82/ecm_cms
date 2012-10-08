module Ecm
  module Cms
    class Routing
      def self.routes(router, options = {})
        options.reverse_merge!({})

        router.match "/*page", :to => "ecm/cms/page#respond", :as => :page
        router.match '/' => "ecm/cms/page#respond", :page => 'home', :as => :root
      end
    end
  end
end

