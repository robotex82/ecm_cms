require 'spec_helper'

describe "content block rendering" do
  before do
    @content_box = Ecm::Cms::ContentBox.create! do |cb|
      cb.name = 'sidebar'
    end

    @page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'foo'
      page.locale   = 'en'
      page.format   = ''
      page.handler  = 'textile'
      page.title    = 'Home'
      page.body     = 'h1. Home'
    end

    content_block = Ecm::Cms::Page::ContentBlock.create! do |cb|
      cb.ecm_cms_page = @page_model
      cb.ecm_cms_content_box = @content_box
      cb.body = 'h1. Sidebar'
    end
  end # before

  context 'when rendering the page' do
    before do
      get "/en/foo"
    end # before

    it 'should render the content block body' do
      response.body.should include("<h1>Sidebar</h1>")
    end # it
  end # context 'when rendering the page'
end # describe "content block rendering"

