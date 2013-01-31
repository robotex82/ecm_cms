require 'spec_helper'

feature 'Ecm::Cms::NavigationItem admin' do
  include ActiveAdmin::SignInHelper

  def set_resource_class
    @resource_class = Ecm::Cms::NavigationItem
  end

  def prepare_for_new
    @navigation = FactoryGirl.create(:ecm_cms_navigation)
  end

  def fill_new_form
    select @navigation.name, :from => 'ecm_cms_navigation_item[ecm_cms_navigation_id]'
    fill_in 'ecm_cms_navigation_item[name]', :with => 'About us'
    fill_in 'ecm_cms_navigation_item[url]', :with => '/about-us'
    fill_in 'ecm_cms_navigation_item[key]', :with => 'about_us'    
  end

  def fill_edit_form
    fill_in "ecm_cms_navigation_item[name]", :with => "About"
  end

  def set_index_check_column
    @index_check_column = :name
  end

  background do
    I18n.locale = :en
    admin_user = FactoryGirl.create(:admin_user)
    sign_in_with(admin_user.email, admin_user.password)

    set_resource_class
    @resource_path = @resource_class.to_s.underscore.gsub('/', '_').pluralize
    @resource_factory_name = @resource_class.to_s.underscore.gsub('/', '_').to_sym
  end # background

  describe 'new' do
    background do
      prepare_for_new
      visit "/admin/#{@resource_path}/new"
    end

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}/new")
    end

    describe 'when filling the form correctly' do
      background do
        fill_new_form
        find(:xpath, '//input[@type="submit"]').click
      end

      scenario 'should have created a record' do
        @resource_class.count.should eq(1)
      end

      scenario 'should redirect to the resource show page' do
        @resource = @resource_class.first
        expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}")
      end
    end
  end

  describe 'show' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
      visit '/admin/#{@resource_path}/#{@resource.to_param}'
    end
  end

  describe 'edit' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
      visit "/admin/#{@resource_path}/#{@resource.to_param}/edit"
    end

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}/edit")
    end

    describe 'when filling the form correctly' do
      background do
        fill_edit_form
        find(:xpath, '//input[@type="submit"]').click
      end

      scenario 'should not have created a record' do
        @resource_class.count.should eq(1)
      end

      scenario 'should redirect to the resource show page' do
        @resource = @resource_class.first
        expect(page.current_path).to eq("/admin/#{@resource_path}/#{@resource.to_param}")
      end
    end

  end

  describe 'delete' do
    background do
      @resource = FactoryGirl.create(@resource_factory_name)
      visit "/admin/#{@resource_path}/#{@resource.to_param}"
      find(:xpath, "//a[@href='/admin/#{@resource_path}/#{@resource.to_param}' and @data-method='delete']").click
    end

    scenario 'should delete the resource' do
      @resource_class.count.should eq(0)
    end

    scenario 'should redirect to the resource index page' do
      expect(page.current_path).to eq("/admin/#{@resource_path}")
    end
  end

  describe 'index' do
    background do
      set_index_check_column
      @resources = FactoryGirl.create_list(@resource_factory_name, 3)
      visit "/admin/#{@resource_path}"
    end

    scenario 'should be visitable' do
      expect(page.current_path).to eq("/admin/#{@resource_path}")
    end

    scenario "should show the resrouces" do
      @resources.each do |resource|
        page.body.should include(resource.send(@index_check_column.to_sym))
      end
    end # scenario
  end
end # feature

