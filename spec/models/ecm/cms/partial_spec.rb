require 'spec_helper'

module Ecm
  module Cms
    describe Partial do
      subject { FactoryGirl.create :ecm_cms_partial }

      context 'associations' do
        it { should belong_to :ecm_cms_folder }
      end

      context 'validations' do
      end

    end
  end
end
