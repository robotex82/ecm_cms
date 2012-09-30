require 'spec_helper'

module Ecm
  module Cms
    describe Partial do
      subject { FactoryGirl.create :ecm_cms_partial }

      context 'associations' do
        it { should belong_to :ecm_cms_folder }
      end

      context 'sets default handler' do
        subject { Ecm::Cms::Partial.new }
        its(:handler) { should eq(Ecm::Cms::Configuration.default_handlers[:partial].to_s) }
      end

      context 'sets default locale' do
        subject { Ecm::Cms::Partial.new }
        its(:locale) { should eq(I18n.locale.to_s) }
      end

      context 'validations' do
        it { should validate_presence_of :basename }
        it { should validate_presence_of :pathname }
        it { should validate_uniqueness_of(:basename).scoped_to(:ecm_cms_folder_id) }

        it { should ensure_inclusion_of(:format).in_array(Mime::SET.symbols.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:format) }

        it { should ensure_inclusion_of(:handler).in_array(ActionView::Template::Handlers.extensions.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:handler) }

        it { should ensure_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
        it { should_not allow_value(%w[foo bar baz]).for(:locale) }

        # TODO: Validate that basename begins with an underscore
      end
    end
  end
end
