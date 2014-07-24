class LargeFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TextHelper
  
  attr_accessor :output_buffer
  
  %w(text_field text_area email_field password_field).each do |form_method|
    define_method(form_method) do |*args|
      attribute = args[0]
      options = args[1] || {}
      options[:label] ||= attribute
      options[:class] ||= "form-control input-lg"
      label_text ||= options.delete(:label).to_s.titleize
      content_tag(:div, class: "form-group #{'has-error' if !object.errors[attribute].empty?}") do
        label_html = label(attribute, label_text, class: "control-label")
         input_html = content_tag(:div, class: "input-group") do
          concat super(attribute, options)
          concat content_tag(:span, "", class: "input-group-addon glyphicon glyphicon-#{options[:gicon]}") if options[:gicon]
            end
        error_html = errors_for_field(attribute)
        
        label_html.html_safe + input_html + error_html
      end
    end
  end
  
  def errors_for_field(attribute, options={})
    return "" if object.errors[attribute].empty?
    content_tag(:p, object.errors[attribute].to_sentence.capitalize, class: "help-block")
  end
  
  def glyph
  end
   
end