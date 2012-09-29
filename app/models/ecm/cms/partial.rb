class Ecm::Cms::Partial < ActiveRecord::Base
  # associations
  belongs_to :ecm_cms_folder,
             :class_name => 'Ecm::Cms::Folder',
             :foreign_key => 'ecm_cms_folder_id'

  # attributes
  attr_accessible :basename,
                  :body,
                  :format,
                  :handler,
                  :layout,
                  :locale,
                  :pathname
end

