require 'spec_helper'

module Ecm
  module Cms
    describe Page do
      subject { FactoryGirl.create :ecm_cms_page }

      context 'associations' do
        it { should belong_to :ecm_cms_folder }
      end

      context 'validations' do
      end

    end
  end
end
