class Ecm::Cms::Partial < ActiveRecord::Base
  self.table_name = 'ecm_cms_partials'

  # add shared behaviour for database backed templates
  include Ecm::Cms::DatabaseTemplate

  # associations
#  belongs_to :ecm_cms_folder,
#             :class_name => 'Ecm::Cms::Folder',
#             :foreign_key => 'ecm_cms_folder_id'

  # attributes
  attr_accessible(:basename,
                  :body,
                  :ecm_cms_folder_id,
                  :format,
                  :handler,
                  :layout,
                  :locale,
                  :pathname) if Rails.version < '4.0.0'

  # callbacks
  before_validation :ensure_basename_starts_with_underscore, :if => Proc.new { |t| t.basename.present? }

  private

  def ensure_basename_starts_with_underscore
    self.basename.insert(0, '_') unless self.basename.start_with?('_')
  end
end

