require 'spec_helper'
describe "home page" do
  it "displays the 'home' page content" do
    page_model = FactoryGirl.create(:ecm_cms_page)
    get "/"
    expect(page).to match(page_model.body)
  end
end
