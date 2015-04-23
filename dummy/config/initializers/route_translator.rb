RouteTranslator.config do |config|
  config.force_locale = true
  config.locale_param_key = :i18n_locale
end if Object.const_defined?('RouteTranslator')
