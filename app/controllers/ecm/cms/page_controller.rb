class Ecm::Cms::PageController < ApplicationController
  # inject locale to params and vice versa
  include RailsTools::I18nController
  
  # add the page resolver
  include Ecm::Cms::ControllerExtensions::PageResolver

  def respond
    render :template => params[:page]
  end
end
