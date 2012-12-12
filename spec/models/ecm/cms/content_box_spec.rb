require 'spec_helper'

module Ecm::Cms
  describe ContentBox do
    context 'associations' do
      it { should have_many :ecm_cms_page_content_blocks }
    end

    context 'validations' do
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of :name }
    end
  end
end

