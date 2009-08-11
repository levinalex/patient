class LabeledFormBuilder < ActionView::Helpers::FormBuilder

  helpers = %w{text_field select date_select text_area}
  
  helpers.each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:p, field_label(field_name, *args) + super)
    end
  end
    
  def submit(*args)
    @template.content_tag(:p, super, :class => "submit")
  end
    
  private
  
  def field_label(field_name, *args)
    options = args.extract_options!
    options[:label_class] = "required" if options[:required]
    label(field_name, options[:label], :class => options[:label_class])
  end
  
  def objectify_options(options)
    super.except(:label, :required, :label_class)
  end
end
