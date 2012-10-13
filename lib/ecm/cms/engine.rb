module Ecm
  module Cms
    class Engine < ::Rails::Engine
      # active admin
      initializer :ecm_cms_engine do
        ::ActiveAdmin.setup do |config|
          config.load_paths += Dir[File.dirname(__FILE__) + '/active_admin']
          config.register_stylesheet 'ecm_cms.css'
        end
      end if defined?(::ActiveAdmin)

      # assets
      if Rails.version >= '3.1'
        initializer "ecm_cms.asset_pipeline" do |app|
          # app.config.assets.precompile << 'ecm_cms.js'
          app.config.assets.precompile << 'ecm_cms.css'
        end
      end      
    end
  end
end

