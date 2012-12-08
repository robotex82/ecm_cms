require 'spec_helper'

describe "requesting a page that renders a partial" do
  it "renders the partial" do
    partial = Ecm::Cms::Partial.create! do |record|
      record.pathname = '/'
      record.basename = 'test'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.body     = 'Test partial'
    end

    record = Ecm::Cms::Template.create! do |record|
      record.pathname = '/'
      record.basename = 'partial_test'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.body     = '<%= render "/test" %>'
    end
    get "/en/partial_test"

    response.body.should include(partial.body)
  end
end
