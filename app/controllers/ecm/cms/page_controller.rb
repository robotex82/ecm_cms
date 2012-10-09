class Ecm::Cms::PageController < ApplicationController
  append_view_path Ecm::Cms::PageResolver.instance unless view_paths.include?(Ecm::Cms::PageResolver.instance)

  def respond
    render :template => params[:page]
  end
end
