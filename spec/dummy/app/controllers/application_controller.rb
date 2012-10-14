class ApplicationController < ActionController::Base
  protect_from_forgery

  # add the page resolver
  append_view_path Ecm::Cms::TemplateResolver.instance unless view_paths.include?(Ecm::Cms::TemplateResolver.instance)
end
