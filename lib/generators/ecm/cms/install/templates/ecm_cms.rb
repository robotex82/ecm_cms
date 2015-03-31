Ecm::Cms.configure do |config|
  config.default_handlers = {
    :page => :texterb,
    :partial => :texterb,
    :template => :texterb
  }

  config.base_controller = 'ApplicationController'
end
