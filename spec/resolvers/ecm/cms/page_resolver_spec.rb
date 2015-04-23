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
        end

        it { subject.should respond_to :find_templates }
        it "should return an Array" do
          expect(subject.find_templates(*@valid_args)).to be_a(Array)
        end

        it "should not return templates if it searches a partial" do
          expect(subject.find_templates(*@partial_args)).to be_empty
        end

        context "page lookup"do
          before(:each) do
            @page = Ecm::Cms::Page.create! do |page|
              page.pathname = '/'
              page.basename = 'foo'
              page.format   = 'html'
              page.handler  = 'erb'
              page.title    = 'Foo Page'
            end
          end

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context "nested page lookup"do
          before(:each) do
            @page = Ecm::Cms::Page.create! do |page|
              page.pathname = '/foo/bar/'
              page.basename = 'baz'
              page.format   = 'html'
              page.handler  = 'erb'
              page.title    = 'Foo Page'
            end
          end

          it "should find templates" do
            @args = [
              "baz",
              "foo/bar",
              false,
              { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context "page lookup without format"do
          before(:each) do
            @page = Ecm::Cms::Page.create! do |page|
              page.pathname = '/'
              page.basename = 'foo'
              page.locale   = ''
              page.format   = ''
              page.handler  = 'textile'
              page.title    = 'h1. A textilized page'
            end
          end

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              { :formats => [ :html ], :locale => [ :en, :de ], :handlers => [ :textile, :erb, :arb, :builder ] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end
      end

      describe "#initialize_template" do
        it { subject.should respond_to :initialize_template }
        it "returns an ActionView Template" do
          record = Ecm::Cms::Page.create! do |page|
            page.pathname = '/'
            page.basename = 'foo'
            page.format   = 'html'
            page.handler  = 'erb'
            page.title    = 'Foo Page'
          end
          details =  { :handlers => [:builder, :erb], :locale => [:de], :formats => [:html] }
          expect(subject.initialize_template(record, details)).to be_a(::ActionView::Template)
        end
      end

      describe "#assert_slashs" do
        it { subject.should respond_to :assert_slashs }

        it "should assert it has slashs on both ends" do
          subject.assert_slashs("foo/bar").should eq("/foo/bar/")
        end
      end

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
        it { expect(subject).to respond_to :normalize_array }
        it "should convert all items to strings" do
          result = subject.normalize_array(@valid_args)
          result.each do |r|
            expect(r).to be_a(String)
          end
        end
      end

      describe "#build_source" do
#        before(:all) do
#          RecordMock = Class.new do
#            attr_accessor :body, :title, :meta_description 
#          end
#        end

        before(:each) do
          @sidebar_content_box = FactoryGirl.build(:ecm_cms_content_box, :name => 'sidebar')
          @footer_content_box = FactoryGirl.build(:ecm_cms_content_box, :name => 'footer')
          @page = Ecm::Cms::Page.new do |page|
            page.body = 'foo'
            page.title = 'bar'
            page.meta_description = 'baz'
            page.ecm_cms_page_content_blocks << FactoryGirl.build(:ecm_cms_page_content_block, :ecm_cms_page => page, :ecm_cms_content_box => @sidebar_content_box, :body => 'sidebar content')
            page.ecm_cms_page_content_blocks << FactoryGirl.build(:ecm_cms_page_content_block, :ecm_cms_page => page, :ecm_cms_content_box => @footer_content_box, :body => 'footer content')
          end
        end

        it "should add a content for block for the title" do
          expect(subject.build_source(@page)).to include("<% content_for :title do %>", "bar", "<% end %>")
        end

        it "should add a content for block for the meta description" do
          expect(subject.build_source(@page)).to include("<% content_for :meta_description do %>", "baz", "<% end %>")
        end

        it "should add a content for block for the associated sidebar content block" do
          expect(subject.build_source(@page)).to include("<% content_for :footer do %>", "sidebar content", "<% end %>")
        end

        it "should add a content for block for the associated footer content block" do
          expect(subject.build_source(@page)).to include("<% content_for :footer do %>", "footer content", "<% end %>")
        end
      end
    end
  end
end

