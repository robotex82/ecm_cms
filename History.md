
1.0.4.pre / 2013-06-06 
======================

  * Fixed: Page Controller did not include the partial resolver.

1.0.3.pre / 2013-03-24 
======================

  * Fixed: Shoulda integration
  * Enhancement: Indented navigation items in the admin area.

1.0.2.pre / 2013-03-20 
==================

  * Fixed: Sorting of pages by filename
  * Fixed: Width of page in admin show views

1.0.1.pre / 2013-03-17 
==================

  * Fixed: Template resolver calling layout on templates causing method not found.
  * Fixed: pages, partials and templates from the database not being preferred.
  * Added history file
  
n.n.n / 2013-03-16 
==================

  * Removed automatic page title rendering from page renderer
  * Fixed creation of pages with content blocks
  * Major cleanup in specs. Removed faker.
  * Moved factories to the correct directory. Better admin area specs. Fixed deprecation in page controllers. Bumped version.
  * Updated bundle Added basic admin interface specs
  * Updated bundle
  * Updated bundle
  * Updated gem dependencies
  * Fixed page title generation
  * Added content block supportxy
  * Renders 404 on missing template
  * Bumped version
  * Refactored Controller integration. Fixed uniqueness validations for basename. Added specs for partial rendering.
  * Fixed text template rendering
  * Fixed require in rake task
  * Bumped version
  * Cleaned up tests
  * Added importers
  * Bumped version
  * Fixes to the backend
  * better locales
  * Better locales
  * Added locale files for models Moved active admin files to the correct place
  * Connected nav items and pages
  * Added pre tags to bodies
  * Added sorting to navigation items
  * Added i18n navigation
  * Finally squashed the bug where exceptions form partials were not being raised correctly
  * Better admin interface
  * Added template support
  * Mokey patches for rendering pages with layouts
  * Added textile support
  * fixed update_url_form_page! visibility in navigation item
  * Added title and meta description tag rendering
  * Fixed nested pages
  * Better admin interface Passing specs
  * Added i18n stuff to the page controller Added i18n routing Added twitter-bootstrap to the dummy app
  * First working cms_render_navigation implementation
  * Added example data rake task. Added connetion between pages and navigation items.
  * Better navigation items.
  * Added to_s method to navigation better active admin resource for navigation
  * Added missing locale validation spec Added active admin resource for navigation
  * Better page model active admin resource for page
  * Added active admin to the dummy app
  * Working page implementation
  * First steps on the page resolver
  * Added page controller Added basic routing
  * Added defaults to models. Added default_handlers setting to initializers. Better specs.
  * Added navigation model Added navigation item model Added basic specs
  * added basic models
  * first commit
