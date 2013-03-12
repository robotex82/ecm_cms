require 'spec_helper'
module Ecm
  module Cms
    describe PageController do
      describe "GET respond with page => '/de/foo'" do
        before(:each) do
          @page = Ecm::Cms::Page.create! do |page|
            page.pathname_en = '/'
            page.basename_en = 'foo'
            page.title_en    = 'Foo Page'

            page.pathname_de = '/'
            page.basename_de = 'foo'
            page.title_de    = 'Foo Seite'

            page.format   = 'html'
            page.handler  = 'erb'
          end
        end

        it "should succeed" do
          get :respond, { :page => '/foo', :i18n_locale => 'de' }
          response.code.should eq('200')
        end
      end

      describe "GET respond with page => '/de/foo/bar'" do
        before(:each) do
          @page = Ecm::Cms::Page.create! do |page|
            page.pathname_en = '/foo/'
            page.basename_en = 'bar'
            page.title_en    = 'Foo/Bar (en)'

            page.pathname_de = '/foo/'
            page.basename_de = 'bar'
            page.title_de    = 'Foo/Bar (de)'

            page.format   = 'html'
            page.handler  = 'erb'
          end
        end

        it "should succeed" do
          get :respond, { :page => '/foo/bar', :i18n_locale => 'de' }
          response.code.should eq('200')
        end
      end
    end
  end
end

