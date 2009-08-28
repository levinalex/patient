class LabeledFormBuilder < ActionView::Helpers::FormBuilder

  helpers = %w{text_field password_field select date_select text_area collection_select}
  
  helpers.each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:p, field_label(field_name, *args) + super)
    end
  end
  
  def check_box(field_name, *args)
    @template.content_tag(:p, super + " " + field_label(field_name, *args))
  end
  
  def many_check_boxes(name, subobjects, id_method, name_method, options = {})
    field_name = "#{object_name}[#{name}][]"
    subobjects.map do |subobject|
      @template.content_tag(:div, :class => subobject.class.to_s.underscore) do
        @template.check_box_tag(field_name, subobject.send(id_method), object.send(name).include?(subobject.send(id_method)), :id => "#{subobject.class.to_s.underscore}_#{subobject.send(id_method)}") + " " + subobject.send(name_method)
      end
    end.to_s + @template.hidden_field_tag(field_name, "")
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
