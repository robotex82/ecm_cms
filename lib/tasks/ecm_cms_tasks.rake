# encoding: utf-8
namespace :ecm do
  namespace :cms do
    namespace :db do
      desc "Purges and creates example data"
      task :populate!, [] => [:environment] do |t, args|
        Rake::Task["ecm:cms:db:clear!"].execute
        Rake::Task["ecm:cms:db:populate"].execute
      end

      desc "Clears all data!"
      task :clear!, [] => [:environment] do |t, args|
        Rake::Task["ecm:cms:db:clear_navigations!"].execute
        Rake::Task["ecm:cms:db:clear_navigation_items!"].execute
        Rake::Task["ecm:cms:db:clear_folders!"].execute
        Rake::Task["ecm:cms:db:clear_pages!"].execute
#        Rake::Task["ecm:cms:db:clear_templates!"].execute
#        Rake::Task["ecm:cms:db:clear_partials!"].execute
      end

      desc "Clears all navigations!"
      task :clear_navigations!, [] => [:environment] do |t, args|
        Ecm::Cms::Navigation.delete_all
      end

      desc "Clears all navigation items!"
      task :clear_navigation_items!, [] => [:environment] do |t, args|
        Ecm::Cms::NavigationItem.delete_all
      end

      desc "Clears all folders!"
      task :clear_folders!, [] => [:environment] do |t, args|
        Ecm::Cms::Folder.delete_all
      end

      desc "Clears all pages!"
      task :clear_pages!, [] => [:environment] do |t, args|
        Ecm::Cms::Page.delete_all
      end

      desc "Clears all partials!"
      task :clear_partials!, [] => [:environment] do |t, args|
        Ecm::Cms::Partial.delete_all
      end

      desc "Clears all templates!"
      task :clear_templates!, [] => [:environment] do |t, args|
        Ecm::Cms::Template.delete_all
      end

      desc "Creates example data"
      task :populate, [] => [:environment] do |t, args|
        Rake::Task["ecm:cms:db:populate_folders"].execute
        Rake::Task["ecm:cms:db:populate_pages"].execute
#        Rake::Task["ecm:cms:db:populate_templates"].execute
#        Rake::Task["ecm:cms:db:populate_partials"].execute
        Rake::Task["ecm:cms:db:populate_navigations"].execute
        Rake::Task["ecm:cms:db:populate_navigation_items"].execute
      end

      desc "Creates example navigations"
      task :populate_navigations, [] => [:environment] do |t, args|
        %w(main legal).each do |name|
          I18n.available_locales.each do |locale|
            Ecm::Cms::Navigation.create! do |n|
              n.locale = locale.to_s
              n.name = name
            end
          end
        end
      end

      desc "Creates example navigation items"
      task :populate_navigation_items, [] => [:environment] do |t, args|
        items = {
          :de => {
            :legal => [
              { :name => 'Impressum', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'impressum', :locale => 'de').first, :key => 'imprint', :url => nil, :options => nil},
              { :name => 'AGB', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'agb', :locale => 'de').first, :key => 'terms_of_service', :url => nil, :options => nil}
            ],
            :main => [
              { :name => 'Home', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'home', :locale => 'de').first, :key => 'home', :url => nil, :options => nil },
              { :name => 'Über uns', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'ueber-uns', :locale => 'de').first, :key => 'about_us', :url => nil , :options => nil },
              { :name => 'Anfahrt', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'anfahrt', :locale => 'de').first, :key => 'approach', :url => nil, :options => nil },
              { :name => 'Kontakt', :ecm_cms_page => nil, :key => 'contact', :url => '/de/kontakt', :options => nil }
            ]
          },
          :en => {
            :legal => [
              { :name => 'Imprint', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'imprint', :locale => 'en').first, :key => 'imprint', :url => nil, :options => nil},
              { :name => 'Terms of Service', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'terms-of-service', :locale => 'en').first, :key => 'terms_of_service', :url => nil, :options => nil}
            ],
            :main => [
              { :name => 'Home', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'home', :locale => 'en').first, :key => 'home', :url => nil, :options => nil },
              { :name => 'About us', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'about-us', :locale => 'en').first, :key => 'about_us', :url => nil , :options => nil },
              { :name => 'Approach', :ecm_cms_page => Ecm::Cms::Page.where(:basename => 'approach', :locale => 'en').first, :key => 'approach', :url => nil, :options => nil },
              { :name => 'Contact', :ecm_cms_page => nil, :key => 'contact', :url => '/en/contact', :options => nil }
            ]
          }
        }.with_indifferent_access

        I18n.available_locales.each do |locale|
          Ecm::Cms::Navigation.where(:locale => locale,:name => [items[locale].keys]).all.each do |navigation|
            items[locale][navigation.name].each do |item|
              navigation.ecm_cms_navigation_items.create!(item)
            end
          end
        end
      end

      desc "Creates example folders"
      task :populate_folders, [] => [:environment] do |t, args|

      end

      desc "Creates example pages"
      task :populate_pages, [] => [:environment] do |t, args|
        pages = {
          :en => [
            { :title => 'Home', :body => '<h1>Home (en)</h1>', :pathname => '/', :basename => 'home', :locale => 'en', :format => 'html', :handler => 'erb' },
            { :title => 'Imprint', :body => '<h1>Imprint (en)</h1>', :pathname => '/', :basename => 'imprint', :locale => 'en', :format => 'html', :handler => 'erb' },            
            { :title => 'About us', :body => '<h1>About us (en)</h1>', :pathname => '/', :basename => 'about-us', :locale => 'en', :format => 'html', :handler => 'erb' },
            { :title => 'Approach', :body => '<h1>Approach (en)</h1>', :pathname => '/', :basename => 'approach', :locale => 'en', :format => 'html', :handler => 'erb' },
            { :title => 'Terms of Service', :body => '<h1>Terms of Service (en)</h1>', :pathname => '/', :basename => 'terms-of-service', :locale => 'en', :format => 'html', :handler => 'erb' }            
          ],
          :de => [
            { :title => 'Home', :body => '<h1>Home (de)</h1>', :pathname => '/', :basename => 'home', :locale => 'de', :format => 'html', :handler => 'erb' },
            { :title => 'Impressum', :body => '<h1>Impressum (de)</h1>', :pathname => '/', :basename => 'impressum', :locale => 'de', :format => 'html', :handler => 'erb' },            
            { :title => 'Über uns', :body => '<h1>Über uns (de)</h1>', :pathname => '/', :basename => 'ueber-uns', :locale => 'de', :format => 'html', :handler => 'erb' },
            { :title => 'Anfahrt', :body => '<h1>Anfahrt (de)</h1>', :pathname => '/', :basename => 'anfahrt', :locale => 'de', :format => 'html', :handler => 'erb' },
            { :title => 'AGB', :body => '<h1>AGB (de)</h1>', :pathname => '/', :basename => 'agb', :locale => 'de', :format => 'html', :handler => 'erb' }            
          ]
        }.with_indifferent_access

        I18n.available_locales.each do |locale|
          pages[locale].each do |page|
            Ecm::Cms::Page.create!(page)
          end if pages.has_key?(locale)
        end
      end

      desc "Creates example templates"
      task :populate_templates, [] => [:environment] do |t, args|

      end

      desc "Creates example partials"
      task :populate_partials, [] => [:environment] do |t, args|

      end
    end
  end
end
