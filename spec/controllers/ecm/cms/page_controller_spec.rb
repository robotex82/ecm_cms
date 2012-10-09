require 'spec_helper'
module Ecm
  module Cms
    describe PageController do
      describe "GET respond with page => 'foo'" do
        before(:each) do
          @page = Ecm::Cms::Page.create! do |page|
            page.pathname = '/'
            page.basename = 'foo'
            page.format   = 'html'            
            page.handler  = 'erb'
            page.title    = 'Foo Page'
          end
        end
        
        it "succeeds" do
          get :respond, { :page => 'foo' }
        end
      end
    end
  end
end

