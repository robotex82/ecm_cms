if Rails::Application::Configuration.respond_to?(:eager_load)
  Formtastic::FormBuilder.action_class_finder = Formtastic::ActionClassFinder
  Formtastic::FormBuilder.input_class_finder = Formtastic::InputClassFinder
end
