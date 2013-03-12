require 'spec_helper'

describe "pages with layouts" do
  before do
    @layout_model = FactoryGirl.create(:ecm_cms_page,
                                       :pathname_en => '/layouts/',
                                       :basename_en => 'foo',
                                       :body_en     => 'Foo Layout <%= yield %>',
                                       :pathname_de => '/layouts/',
                                       :basename_de => 'foo',
                                       :body_de     => 'Foo Layout <%= yield %>',
                                       :format      => 'html',
                                       :handler     => 'erb'
    )

    @page_model = FactoryGirl.create(:ecm_cms_page,
                                     :pathname_en => '/',
                                     :basename_en => 'home',
                                     :pathname_de => '/',
                                     :basename_de => 'home',
                                     :format      => 'html',
                                     :layout      => 'layouts/foo',
                                     :handler     => 'erb'
    )
  end # before

  it "should render the page with the specified layout" do
    # TODO: replace this with a template as soon as the template model is done.
    get "/en"
    response.body.should include('Foo Layout')
  end
end

