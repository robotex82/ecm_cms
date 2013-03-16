module Ecm
  module Cms
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc "Copies the locale files to your application"

        source_root File.expand_path('../../../../../../config/locales', __FILE__)

        def generate_locales
          copy_file "ecm.cms.en.yml", "config/locales/ecm.cms.en.yml"
          copy_file "ecm.cms.de.yml", "config/locales/ecm.cms.de.yml"

          copy_file "ecm.cms.content_box.en.yml", "config/locales/ecm.cms.content_box.en.yml"
          copy_file "ecm.cms.content_box.de.yml", "config/locales/ecm.cms.content_box.de.yml"

          copy_file "ecm.cms.navigation.en.yml", "config/locales/ecm.cms.navigation.en.yml"
          copy_file "ecm.cms.navigation.de.yml", "config/locales/ecm.cms.navigation.de.yml"

          copy_file "ecm.cms.navigation_item.en.yml", "config/locales/ecm.cms.navigation_item.en.yml"
          copy_file "ecm.cms.navigation_item.de.yml", "config/locales/ecm.cms.navigation_item.de.yml"

          copy_file "ecm.cms.page.en.yml", "config/locales/ecm.cms.page.en.yml"
          copy_file "ecm.cms.page.de.yml", "config/locales/ecm.cms.page.de.yml"

          copy_file "ecm.cms.page.content_block.en.yml", "config/locales/ecm.cms.page.content_block.en.yml"
          copy_file "ecm.cms.page.content_block.de.yml", "config/locales/ecm.cms.page.content_block.de.yml"

          copy_file "ecm.cms.partial.en.yml", "config/locales/ecm.cms.partial.en.yml"
          copy_file "ecm.cms.partial.de.yml", "config/locales/ecm.cms.partial.de.yml"

          copy_file "ecm.cms.template.en.yml", "config/locales/ecm.cms.template.en.yml"
          copy_file "ecm.cms.template.de.yml", "config/locales/ecm.cms.template.de.yml"
        end
      end
    end
  end
end

