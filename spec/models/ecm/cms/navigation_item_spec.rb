require 'spec_helper'

module Ecm
  module Cms
    describe NavigationItem do
      subject { FactoryGirl.create :ecm_cms_navigation_item }

      context 'associations' do
        it { should belong_to :ecm_cms_navigation }
      end

      context 'validations' do
        it { should validate_presence_of :key }
        it { should validate_presence_of :name }
        it { should validate_presence_of :url }
      end
    end
  end
end
