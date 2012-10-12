require 'active_admin-awesome_nested_set'
require 'awesome_nested_set'
require 'i18n_routing'
require 'rails_tools/i18n_controller'
require 'simple-navigation'
require 'simple-navigation-bootstrap'

require 'ecm/cms/engine'
require 'ecm/cms/configuration'
require 'ecm/cms/routing'
require 'ecm/cms/resolvers/ecm/cms/page_resolver'

module Ecm
  module Cms
    extend Configuration
  end
end
