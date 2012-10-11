module RailsTools
  module I18nController
    def set_locale
      I18n.locale = params[:i18n_locale]
    end

    def default_url_options(options = {})
      { :i18n_locale => I18n.locale }
    end


    def self.included(base)
      base.before_filter :set_locale
      base.extend(ClassMethods)
    end

    module ClassMethods
      def self.default_url_options(options = {})
        { :i18n_locale => I18n.locale }
      end
    end
  end
end

