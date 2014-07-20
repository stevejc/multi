class BasicFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  
  attr_accessor :output_buffer
  
  %w(text_field text_area email_field password_field).each do |form_method|
    define_method(form_method) do |*args|
      attribute = args[0]
      options = args[1] || {}
      options[:label] ||= attribute
      options[:class] = "form-control"
      label_text ||= options.delete(:label).to_s.titleize
      content_tag(:div, class: "form-group #{'has-error' if !object.errors[attribute].empty?}") do
        label(attribute, label_text, class: "control-label") +
        super(attribute, options) + errors_for_field(attribute)
      end
    end
  end
  
  def errors_for_field(attribute, options={})
    return "" if object.errors[attribute].empty?
    content_tag(:p, object.errors[attribute].to_sentence.capitalize, class: "help-block")
  end
  
end

