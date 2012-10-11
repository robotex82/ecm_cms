module Ecm::CmsHelper
  def cms_render_navigation(name, options = {})
    navigation = Ecm::Cms::Navigation.where(:name => name.to_s, :locale => I18n.locale.to_s).first

    return I18n.t('ecm.cms.navigation.messages.not_found', {:lang => I18n.locale.to_s, :name => name.to_s}) unless navigation

    options[:items] = []
    navigation.ecm_cms_navigation_items.roots.all.each do |ni|
      options[:items] << build_navigation(ni)
    end

    return I18n.t('ecm.cms.navigation.messages.empty', :lang => I18n.locale.to_s, :name => name) if options[:items].empty?
    render_navigation(options)
  end

  def build_navigation(navigation_item)
    if navigation_item.children.count > 0
      items = []
      navigation_item.children.each do |child|
        items << build_navigation(child)
      end
      #output = { :key => navigation_item.key, :name => navigation_item.name, :url => eval(navigation_item.url), :items => items }
      output = { :key => navigation_item.key, :name => navigation_item.name, :url => navigation_item.url, :items => items }
    else
      #output = { :key => navigation_item.key, :name => navigation_item.name, :url => eval(navigation_item.url) }
      output = { :key => navigation_item.key, :name => navigation_item.name, :url => navigation_item.url }
    end

    begin
      options = eval(navigation_item.options)
      output[:options] = options if options.is_a?(Hash)
    rescue
      logger.debug "Invalid navigation item options: #{navigation_item.options}"
    end

    return output
  end
end

