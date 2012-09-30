Ecm::Cms.configure do |config|
  config.default_handlers = {
    :page => :texterb,
    :partial => :texterb,
    :template => :texterb
  }
end
