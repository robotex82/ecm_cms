module Ecm
  module Cms
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc "Copies the locale files to your application"

        source_root File.expand_path('../../../../../../config/locales', __FILE__)
        
        def generate_locales
          copy_file "ecm.cms.en.yml", "config/locales/ecm.cms.en.yml"
          copy_file "ecm.cms.de.yml", "config/locales/ecm.cms.de.yml"
        end   
      end
    end
  end
end        
