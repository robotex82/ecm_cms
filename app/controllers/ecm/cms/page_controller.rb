class Ecm::Cms::PageController < ApplicationController
  # inject locale to params and vice versa
  include RailsTools::I18nController
  
  # add the page resolver
  append_view_path Ecm::Cms::PageResolver.instance unless view_paths.include?(Ecm::Cms::PageResolver.instance)

  def respond
    render :template => params[:page]
  end
end
