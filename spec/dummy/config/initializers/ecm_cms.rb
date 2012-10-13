Ecm::Cms.configure do |config|
  config.default_handlers = {
    :page => :texterb,
    :partial => :texterb,
    :template => :texterb
  }

  config.site_title = Rails.application.class.parent_name
end
