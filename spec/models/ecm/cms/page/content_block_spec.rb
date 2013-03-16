require 'spec_helper'

module Ecm::Cms
  describe Page::ContentBlock do
    context 'associations' do
      it { should belong_to :ecm_cms_content_box }
      it { should belong_to :ecm_cms_page }
    end

    context 'validations' do
      it { should validate_presence_of :body }
      it { should validate_presence_of :ecm_cms_content_box }
      it { should validate_presence_of :ecm_cms_page }
    end
  end
end

