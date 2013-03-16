require 'spec_helper'

describe "requesting '/' redirects to the default locale" do
  it "redirects" do
    get "/"
    response.should redirect_to("/#{I18n.default_locale}")
  end
end

describe "localized home page" do
  it "displays the 'home' page content" do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'home'
      page.locale   = 'en'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'Home'
      page.body     = '<h1>Home</h1>'
    end
    get "/en"

    response.body.should include(page_model.body)
  end

  describe "requesting nested page" do
    it "requesting /foo/bar/baz should succeed" do
      page_model = Ecm::Cms::Page.create! do |page|
        page.pathname = '/foo/bar/'
        page.basename = 'baz'
        page.locale   = 'en'
        page.format   = 'html'
        page.handler  = 'erb'
        page.title    = 'Home'
        page.body     = '<h1>Foo/Bar</h1>'
      end
      get "/en/foo/bar/baz"

      response.body.should include(page_model.body)
    end
  end

  describe "requesting text template" do
    it "requesting /de/test.txt should succeed" do
      page_model = Ecm::Cms::Page.create! do |page|
        page.pathname = '/'
        page.basename = 'test'
        page.format   = 'text'
        page.handler  = 'erb'
        page.title    = 'Test'
        page.body     = 'Example text template'
      end
      get "/de/test.txt"

      response.body.should include(page_model.body)
    end
  end
end

describe 'page with content blocks' do
  it 'should render the page block content' do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'test'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'Page with content block'
      page.body     = 'Footer content here: <%= content_for?(:footer) ? yield(:footer) : nil %>'
    end

    content_box = Ecm::Cms::ContentBox.create! do |content_box|
      content_box.name = 'footer'
    end
    
    footer_content_block = page_model.ecm_cms_page_content_blocks.create! do |content_block|
      content_block.ecm_cms_content_box = content_box
      content_block.body = 'This is the footer content'
    end
    get "/de/test"

    response.body.should include(footer_content_block.body)
  end
end

