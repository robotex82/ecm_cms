require 'ecm/cms/action_view/template/handlers/textile'
require 'ecm/cms/action_view/template_patch'
require 'ecm/cms/action_view/template_renderer_patch'
require 'active_admin-awesome_nested_set'
require 'awesome_nested_set'
require 'i18n_routing'
require 'polyglotism'
require 'rails_tools/i18n_controller'
require 'redcloth'
require 'simple-navigation'
require 'simple-navigation-bootstrap'

require 'ecm/cms/engine'
require 'ecm/cms/configuration'
require 'ecm/cms/routing'

# require 'ecm/cms/database_resolver'
require 'ecm/cms/database_template'
require 'ecm/cms/database_i18n_template'

require 'ecm/cms/resolvers/ecm/cms/page_resolver'
require 'ecm/cms/resolvers/ecm/cms/template_resolver'
require 'ecm/cms/resolvers/ecm/cms/partial_resolver'

require 'ecm/cms/controller_extensions/page_resolver'
require 'ecm/cms/controller_extensions/partial_resolver'
require 'ecm/cms/controller_extensions/template_resolver'

::ActionView::Template.register_template_handler :textile, ::ActionView::Template::Handlers::Textile.new

module Ecm
  module Cms
    extend Configuration
  end
end

