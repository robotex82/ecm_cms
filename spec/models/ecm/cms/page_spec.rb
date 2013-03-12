require 'spec_helper'

module Ecm
  module Cms
    describe Page do
      subject { FactoryGirl.create :ecm_cms_page }

      context 'associations' do
        it { should belong_to :ecm_cms_folder }
        it { should have_many :ecm_cms_page_content_blocks }
      end

      context 'callbacks' do
        subject { Ecm::Cms::Template.new }

        it "adds a '/' to the pathname before validation" do
          subject.pathname = 'bar'
          subject.save
          subject.pathname.should eq('bar/')
        end

        context 'sets default handler on initialization' do
          its(:handler) { should eq(Ecm::Cms::Configuration.default_handlers[:page].to_s) }
        end

        context 'sets default locale on initialization' do
          before(:each) { I18n.locale = :de }
          its(:locale) { should eq(I18n.locale.to_s) }
        end
      end

      context 'validations' do
        I18n.available_locales.each do |locale|
          it { should validate_presence_of "basename_#{locale}" }
          it { should validate_presence_of "title_#{locale}" }
          it { should validate_uniqueness_of("basename_#{locale}").scoped_to(["pathname_#{locale}", :format, :handler]) }
        end

        # Removed test to respect adding a trailing slash to pathname before validation
        # if pathname is blank
        # it { should validate_presence_of :pathname }

        it { should ensure_inclusion_of(:format).in_array(Mime::SET.symbols.map(&:to_s)) }
        it { should_not allow_value('foo').for(:format) }

        it { should ensure_inclusion_of(:handler).in_array(ActionView::Template::Handlers.extensions.map(&:to_s)) }
        it { should_not allow_value('foo').for(:handler) }
      end

      context '#filename' do
        subject { Ecm::Cms::Page.new }

        it "builds foo.html from basename => foo, handler => html" do
          subject.basename = 'foo'
          subject.handler  = 'html'

          subject.filename.should eq('foo.html')
        end
      end

      context "#home_page?" do
        subject { Ecm::Cms::Page.new() }

        it "should return true if the pathname is '/' and the basename is 'home'" do
          subject.pathname = '/'
          subject.basename = 'home'

          subject.home_page?.should be(true)
        end

        it "should return false if the pathname is '/foo' and the basename is 'home'" do
          subject.pathname = '/foo'
          subject.basename = 'home'

          subject.home_page?.should be(false)
        end

        it "should return false if the pathname is '/' and the basename is 'foo'" do
          subject.pathname = '/'
          subject.basename = 'foo'

          subject.home_page?.should be(false)
        end
      end
    end
  end
end

