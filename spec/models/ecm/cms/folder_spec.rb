require 'spec_helper'

module Ecm
  module Cms
    describe Folder do
      subject { FactoryGirl.create :ecm_cms_folder }

      context 'associations' do
        it { should have_many :ecm_cms_pages }
        it { should have_many :ecm_cms_partials }
        it { should have_many :ecm_cms_templates }
      end

      context 'validations' do
        it { should validate_presence_of :pathname }
        it { should validate_presence_of :basename }
      end

    end
  end
end
