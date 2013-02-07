class Ecm::Cms::PageController < ApplicationController
  # inject locale to params and vice versa
  include RailsTools::I18nController
  
  # add the page resolver
  include Ecm::Cms::ControllerExtensions::PageResolver

  # avoid error 500 on missing template
  rescue_from ActionView::MissingTemplate do
    respond_to do |format|
      # format.html { render(:file => "#{Rails.root}/public/404.html", :layout => false, :status => 404) }
      format.html { render(:file => "#{Rails.root}/public/404", :formats => [:html], :status => 404, :layout => false) }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def respond
    render :template => params[:page]
  end
end
