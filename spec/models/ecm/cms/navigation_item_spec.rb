require 'spec_helper'

module Ecm
  module Cms
    describe NavigationItem do
      subject { FactoryGirl.create :ecm_cms_navigation_item }

      context 'associations' do
        it { should belong_to :ecm_cms_navigation }
        it { should belong_to :ecm_cms_page }        
      end

      context 'callbacks' do
        context '#update_navigation_from_parent' do
          it "should set the navigation from the parent item" do
            root = FactoryGirl.create :ecm_cms_navigation_item
            foo  = FactoryGirl.create :ecm_cms_navigation_item, :parent => root         
            
            foo.valid?
            foo.ecm_cms_navigation.should eq(root.ecm_cms_navigation)
          end
        end

        context '#update_children_navigations!' do
          it "should set the new navigation on all descendants" # do
#            n1 = FactoryGirl.create :ecm_cms_navigation
#            n2 = FactoryGirl.create :ecm_cms_navigation       
#            foo = FactoryGirl.create :ecm_cms_navigation_item, :ecm_cms_navigation => n1
#            bar = FactoryGirl.build :ecm_cms_navigation_item # , :parent => foo
#            bar.parent = foo
#            bar.save!
#            
#            foo.ecm_cms_navigation = n2
#            foo.save!
#            bar.ecm_cms_navigation.should == n2
#          end
        end

        context "#update_url_form_page" do
          it "should set the url from page if url is blank and page is present" do
            basename = 'about-us'
            locale = 'en'
            page = FactoryGirl.build :ecm_cms_page, :basename => basename, :locale => locale
            ni = FactoryGirl.build :ecm_cms_navigation_item, :url => nil, :ecm_cms_page => page
            
            ni.valid?
            ni.url.should eq('/en/about-us')
          end

          it "should set the correct url for home pages" do
            page = FactoryGirl.build :ecm_cms_page, :pathname => '/', :basename => 'home', :locale => 'en'
            ni = FactoryGirl.build :ecm_cms_navigation_item, :url => nil, :ecm_cms_page => page
            
            ni.valid?
            ni.url.should eq('/en')
          end
        end
      end

      context 'validations' do
        it { should validate_presence_of :key }
        it { should validate_presence_of :name }
        it { should validate_presence_of :url }
        # Removed due to missing if support
        # it { should validate_presence_of :ecm_cms_navigation }
        it "should validate presence of :ecm_cms_navigation if it is a root item" do
          navigation_item = FactoryGirl.build :ecm_cms_navigation_item_root, :ecm_cms_navigation => nil
          navigation_item.should_not be_valid
        end
        
        it "should not validate presence of :ecm_cms_navigation if it is a child item" do
          navigation_item = FactoryGirl.build :ecm_cms_navigation_item_child, :ecm_cms_navigation => nil
          navigation_item.should be_valid
        end
      end

      context "#params_for_new_page" do
        context "for a new record" do
          subject { Ecm::Cms::NavigationItem.new }

          it "should return an empty hash if the record is not persisted" do
            subject.params_for_new_page.should eq({})
          end
        end

        context "for a persisted object" do
          subject { FactoryGirl.create(:ecm_cms_navigation_item) }

          it "should return the correct params when having the url '/en/contact'" do
            subject.url = '/en/contact'
            subject.name = "Contact"

            expected_params = { :locale => 'en', :pathname => '/', :basename => 'contact', :title => subject.name, :ecm_cms_navigation_item_ids => [ subject.to_param ] }
            subject.params_for_new_page.should eq(expected_params)
          end

          it "should return the correct params when having the url '/en'" do
            subject.url = '/en'
            subject.name = "Home"

            expected_params = { :locale => 'en', :pathname => '/', :basename => 'home', :title => subject.name, :ecm_cms_navigation_item_ids => [ subject.to_param ] }
            subject.params_for_new_page.should eq(expected_params)
          end
        end
      end
    end
  end
end
