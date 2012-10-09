require 'spec_helper'

module Ecm
  module Cms
    describe Page do
      subject { FactoryGirl.create :ecm_cms_page }

      context 'associations' do
        it { should belong_to :ecm_cms_folder }
      end

      context 'callbacks' do
        it "adds a '/' to the pathname before validation" do
          page = FactoryGirl.build :ecm_cms_page, :pathname => 'bar'
          page.save
          page.pathname.should eq('bar/')
        end
      end

      context 'sets default handler' do
        subject { Ecm::Cms::Page.new }
        its(:handler) { should eq(Ecm::Cms::Configuration.default_handlers[:page].to_s) }
      end

      context 'sets default locale' do
        subject { Ecm::Cms::Page.new }
        its(:locale) { should eq(I18n.locale.to_s) }
      end

      context 'validations' do
        it { should validate_presence_of :basename }
        # Removed test to respect adding a trailing slash to pathname before validation
        # if pathname is blank
        # it { should validate_presence_of :pathname }
        it { should validate_presence_of :title }
        it { should validate_uniqueness_of(:basename).scoped_to(:ecm_cms_folder_id) }

        it { should ensure_inclusion_of(:format).in_array(Mime::SET.symbols.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:format) }

        it { should ensure_inclusion_of(:handler).in_array(ActionView::Template::Handlers.extensions.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:handler) }

        it { should ensure_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:locale) }
      end

      context '#filename' do
        it "builds foo.html from basename => foo, handler => html" do
          page = Ecm::Cms::Page.new
          page.basename = 'foo'
          page.locale   = nil
          page.handler  = 'html'
          
          page.filename.should eq('foo.html')
        end

        it "builds foo.en.html from basename => foo, locale => en, handler => html" do
          page = Ecm::Cms::Page.new
          page.basename = 'foo'
          page.locale   = 'en'
          page.handler  = 'html'
          page.filename.should eq('foo.en.html')
        end
      end
    end
  end
end
