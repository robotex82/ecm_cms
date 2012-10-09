require 'spec_helper'

module Ecm
  module Cms
    describe Navigation do
      subject { FactoryGirl.create :ecm_cms_navigation }

      context 'associations' do
        it { should have_many :ecm_cms_navigation_items }
      end

      context 'validations' do
        it { should validate_presence_of :name }
        it { should validate_uniqueness_of(:name).scoped_to(:locale) }
        it { should ensure_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
      end
    end
  end
end
