require 'spec_helper'

describe "requesting '/en/contact' renders a template from database" do
  it "displays the '/contact/index.html.erb' page content" do
    record = Ecm::Cms::Template.create! do |record|
      record.pathname = '/contact/'
      record.basename = 'index'
      record.locale   = ''
      record.format   = 'html'
      record.handler  = 'erb'
      record.body     = '<h1>contact#index</h1>\nFind me in contact/index.html.erb\n'
    end
    get "/en/contact"

    response.body.should include(record.body)
  end
end
