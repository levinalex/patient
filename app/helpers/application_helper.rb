# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_error_messages(*objects)
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    render 'error_messages', :object => messages unless messages.empty?
  end
  
  def labeled_form_for(*args, &block)
    options = args.extract_options!.merge(:builder => LabeledFormBuilder)
    form_for(*(args + [options]), &block)
  end
end
