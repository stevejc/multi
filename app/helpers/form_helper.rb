module FormHelper
  def errors_for(form, field)
    content_tag(:p, form.object.errors[field].try(:first), class: 'help-block')
  end

  def form_group_for(form, field, opts={}, &block)

    if opts.has_key?(:label)
       label = opts.fetch(:label)
    else
     label = field.to_s
    end
 
    has_errors = form.object.errors[field].present?

    content_tag :div, class: "form-group #{'has-error' if has_errors}" do
      if label != false
        concat form.label(label, class: 'control-label')
      end
      concat capture(&block)
      concat errors_for(form, field)
    end
  end
end

