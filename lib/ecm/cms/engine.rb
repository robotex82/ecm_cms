module Ecm
  module Cms
    class Engine < ::Rails::Engine
      # config.eager_load_paths += Dir["#{config.root}/lib/**/"]
      
      config.app_generators do |c|
        c.test_framework :rspec, :fixture => true,
                                 :fixture_replacement => nil

        c.integration_tool :rspec
        c.performance_tool :rspec
      end

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

