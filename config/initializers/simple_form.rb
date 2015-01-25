SimpleForm.setup do |config|
  config.wrappers :default, class: 'input' do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label
    b.use :hint
    b.use :input, class: 'input'
    b.use :error, wrap_with: { tag: :span, class: 'input__error-message' }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = nil
  config.error_method = :to_sentence
  config.error_notification_tag = :div
  config.error_notification_class = 'error-notification'
  config.default_form_class = nil
  config.browser_validations = false
  config.cache_discovery = !Rails.env.development?
  config.boolean_label_class = 'checkbox'
  config.item_wrapper_class = nil
  config.generate_additional_classes_for = []
  config.input_class = nil

  # config.error_notification_id = nil
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]
  # config.collection_value_methods = [ :id, :to_s ]
  # config.collection_wrapper_tag = nil
  # config.collection_wrapper_class = nil
  # config.item_wrapper_tag = :span

  config.label_text = ->(label, _required, _explicit_label) { "#{label.titleize}" }
  # config.label_class = nil
  # config.required_by_default = true
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]
  # config.input_mappings = { /count/ => :integer }
  # config.wrapper_mappings = { string: :prepend }
  # config.custom_inputs_namespaces << "CustomInputs"
  # config.time_zone_priority = nil
  # config.country_priority = nil
  # config.translate_labels = true
  # config.inputs_discovery = true
  # config.include_default_input_wrapper_class = true
  # config.i18n_scope = 'simple_form'
end

module InputErrorClass
  def input_html_classes
    super.tap do |classes|
      if !classes.include?('input--is-invalid') && has_errors? && errors.present?
        classes << 'input--is-invalid'
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:prepend, InputErrorClass)
