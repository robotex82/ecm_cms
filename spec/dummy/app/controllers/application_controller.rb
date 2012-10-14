class ApplicationController < ActionController::Base
  protect_from_forgery

  # add the page resolver
  append_view_path Ecm::Cms::TemplateResolver.instance unless view_paths.include?(Ecm::Cms::TemplateResolver.instance)

  # add the partial resolver
  append_view_path Ecm::Cms::PartialResolver.instance unless view_paths.include?(Ecm::Cms::PartialResolver.instance)
end

