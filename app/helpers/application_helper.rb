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
  
  def navigation(*links)
    items = []
    links.each do |link|
      if controller.controller_name.to_sym == link[0] || "admin_#{controller.controller_name}".to_sym == link[0]
        items << content_tag(:li, link_to("#{link[1].to_s}", link[0]), :class => "active")
      else
        items << content_tag(:li, link_to("#{link[1].to_s}", link[0]))
      end
    end
    content_tag :ul, items
  end
  
  def twill_paginate(collection = nil, options = {})
    will_paginate collection, {:previous_label => t('will_paginate.previous'), :next_label => t('will_paginate.next')}.merge(options)
  end
end
