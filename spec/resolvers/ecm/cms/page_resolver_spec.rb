require 'spec_helper'

module Ecm
  module Cms
    describe PageResolver do
      subject { Ecm::Cms::PageResolver.instance }

      describe "#find_templates" do
        before do
          @valid_args = [
            "foo",
            "",
            false,
            { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
          ]

          @partial_args = [
            "foo",
            "",
            true,
            { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
          ]
        end # before

        it { subject.should respond_to :find_templates }
        it "should return an Array" do
          subject.find_templates(*@valid_args).should be_a(Array)
        end # it

        it "should not return templates if it searches a partial" do
          subject.find_templates(*@partial_args).should be_empty
        end # it

        context "page lookup" do
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
          end # before

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
            ]
            subject.find_templates(*@args).size.should eq(1)
          end # it
        end # context "page lookup"

        describe "nested page lookup" do
          before do
            @page = Ecm::Cms::Page.create! do |page|
              page.pathname_en = '/foo/bar/'
              page.basename_en = 'baz'
              page.title_en    = 'Foo Page'

              page.pathname_de = '/foo/bar/'
              page.basename_de = 'baz'
              page.title_de    = 'Foo Seite'

              page.format   = 'html'
              page.handler  = 'erb'
            end
          end # before

          it "should find templates" do
            @args = [
              "baz",
              "foo/bar",
              false,
              { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
            ]
            subject.find_templates(*@args).size.should eq(1)
          end # it
        end # describe "nested page lookup"

        describe "page lookup without format" do
          before do
            @page = Ecm::Cms::Page.create! do |page|
              page.pathname_en = '/'
              page.basename_en = 'foo'
              page.title_en    = 'h1. A textilized page'

              page.pathname_de = '/'
              page.basename_de = 'foo'
              page.title_de    = 'h1. Eine Seite im Textile Format'

              page.format   = ''
              page.handler  = 'textile'
            end
          end # before

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              { :formats => [ :html ], :locale => [ :en, :de ], :handlers => [ :textile, :erb, :arb, :builder ] }
            ]
            subject.find_templates(*@args).size.should eq(1)
          end # it
        end # describe "page lookup without format"
      end # describe "#find_templates"

      describe "#initialize_template" do
        it { subject.should respond_to :initialize_template }

        it "should return an ActionView Template" do
          record = Ecm::Cms::Page.create! do |page|
            page.pathname_en = '/'
            page.basename_en = 'foo'
            page.title_en    = 'Foo Page'

            page.pathname_de = '/'
            page.basename_de = 'foo'
            page.title_de    = 'Foo Seite'

            page.format   = 'html'
            page.handler  = 'erb'
          end
          details =  { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
          subject.initialize_template(record, details).should be_a(::ActionView::Template)
        end # it
      end # describe "#initialize_template"

      describe "#assert_slashs" do
        it { subject.should respond_to :assert_slashs }

        it "should assert it has slashs on both ends" do
          subject.assert_slashs("foo/bar").should eq("/foo/bar/")
        end # it
      end # describe "#assert_slashs"

#      describe "#normalize_path" do
#        it { subject.should respond_to :normalize_path }

#        it "should normalize the path" do
#          subject.normalize_path("index", "users").should eq("users/index")
#        end
#      end

      describe "#normalize_array" do
        before do
          @valid_args = [
            [ 1, 2, 3, 4, 5 ]
          ]
        end
        it { subject.should respond_to :normalize_array }
        it "should convert all items to strings" do
          result = subject.normalize_array(@valid_args)
          result.each do |r|
            r.should be_a(String)
          end
        end
      end

      describe "#build_source" do
        before do
          @sidebar_content_box = FactoryGirl.build(:ecm_cms_content_box, :name => 'sidebar')
          @footer_content_box = FactoryGirl.build(:ecm_cms_content_box, :name => 'footer')
          @page = Ecm::Cms::Page.new do |page|
            page.body = 'foo'
            page.title = 'bar'
            page.meta_description = 'baz'
            page.ecm_cms_page_content_blocks << FactoryGirl.build(:ecm_cms_page_content_block, :ecm_cms_page => page, :ecm_cms_content_box => @sidebar_content_box, :body => 'sidebar content')
            page.ecm_cms_page_content_blocks << FactoryGirl.build(:ecm_cms_page_content_block, :ecm_cms_page => page, :ecm_cms_content_box => @footer_content_box, :body => 'footer content')
          end
        end # before

        it "should add a content for block for the title" do
          subject.build_source(@page).should include("<% content_for :title do %>", "bar", "<% end %>")
        end # it

        it "should add a content for block for the meta description" do
          subject.build_source(@page).should include("<% content_for :meta_description do %>", "baz", "<% end %>")
        end # it

        it "should add a content for block for the associated sidebar content block" do
          subject.build_source(@page).should include("<% content_for :footer do %>", "sidebar content", "<% end %>")
        end # it

        it "should add a content for block for the associated footer content block" do
          subject.build_source(@page).should include("<% content_for :footer do %>", "footer content", "<% end %>")
        end # it
      end # describe "#build_source"
    end # describe PageResolver
  end # module Cms
end # module Ecm

