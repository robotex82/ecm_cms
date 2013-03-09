require 'spec_helper'
module Ecm
  describe CmsHelper do
    describe "#build_navigation" do
      it "generated the correct output" do
        navigation_item = FactoryGirl.create(:ecm_cms_navigation_item)
        expected_output = { :key => navigation_item.key, :name => navigation_item.name, :url => navigation_item.url }
        expect(helper.build_navigation(navigation_item)).to eq(expected_output)
      end

      it "supports url evaling"
      it "support option evaling"
    end

    describe "#cms_render_navigation" do
      it "shows an warning on missing navigation" do
        name = 'main'
        expect(helper.cms_render_navigation(name)).to eq(I18n.t('ecm.cms.navigation.messages.not_found', {:lang => I18n.locale.to_s, :name => name.to_s}))
      end

      it "shows an warning on empty navigation" do
        name = 'main'
        navigation = FactoryGirl.create :ecm_cms_navigation, :name => name
        expect(helper.cms_render_navigation(name)).to eq(I18n.t('ecm.cms.navigation.messages.empty', {:lang => I18n.locale.to_s, :name => name.to_s}))
      end

      it "renders the navigation" do
        name = 'main'
        navigation = FactoryGirl.create :ecm_cms_navigation, :name => name
        items = [
          { :ecm_cms_navigation => navigation, :name => 'Home', :url => "/#{I18n.locale.to_s}/", :key => 'home', :options => nil },
          { :ecm_cms_navigation => navigation, :name => 'About us', :url => "/#{I18n.locale.to_s}/about-us", :key => 'about_us' , :options => nil },
          { :ecm_cms_navigation => navigation, :name => 'Approach', :url => "/#{I18n.locale.to_s}/approach", :key => 'approach', :options => nil },
          { :ecm_cms_navigation => navigation, :name => 'Contact', :url => "/#{I18n.locale.to_s}/contact", :key => 'contact', :options => nil }
        ]
        Ecm::Cms::NavigationItem.create(items)
        items.each do |i|
          expect(helper.cms_render_navigation(name)).to match /#{i[:name]}/
        end
      end
    end
  end
end

