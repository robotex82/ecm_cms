require 'spec_helper'

describe "pages with different layouts" do
  it "uses page specific layouts" do
    # TODO: replace this with a template as soon as the template model is done.
    layout_model = FactoryGirl.create(:ecm_cms_page, 
                                      :pathname => '/layouts/', 
                                      :basename => 'foo', 
                                      :locale   => '', 
                                      :format   => 'html', 
                                      :handler  => 'erb',
                                      :body     => 'Foo Layout <%= yield %>'
    )

    page_model = FactoryGirl.create(:ecm_cms_page, 
                                    :pathname => '/', 
                                    :basename => 'home', 
                                    :locale   => 'en', 
                                    :format   => 'html', 
                                    :layout   => 'layouts/foo',
                                    :handler  => 'erb'
    )
    get "/en"
    # This does not work :(
    # response.should render_template('layouts/foo')

    response.body.should include('Foo Layout')
  end
end

