class ApplicationController < ActionController::Base
  protect_from_forgery

  # add the template resolver
  include Ecm::Cms::ControllerExtensions::TemplateResolver

  # add the partial resolver
  include Ecm::Cms::ControllerExtensions::PartialResolver
end

