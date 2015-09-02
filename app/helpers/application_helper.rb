module ApplicationHelper

	def page_title(title, &block)
    page_actions = block_given? ? capture(&block) : ''
    content_tag(:div, class: "page-title") do
      content_tag(:h1, (title + page_actions).html_safe)
    end
  end

  def page_section(title)
    content_tag(:div, class: "page-section") do
      content_tag(:h3, title.html_safe)
    end
  end

  def submit_or_cancel(form, submit_name = "", cancel_name="#{t 'cancel'}")
    unless submit_name.blank?
      form.submit(submit_name, class: 'btn btn-primary', data: {disable_with: "#{t 'please_wait'}"}) + " #{t 'or'} " + link_to(cancel_name, 'javascript:history.go(-1);', class: 'cancel')
    else
      form.submit(class: 'btn btn-primary', data: {disable_with: "#{t 'please_wait'}"}) + " #{t 'or'} " + link_to(cancel_name, 'javascript:history.go(-1);', class: 'cancel')
    end
  end

  CURRENCIES_SUPPORTED = [ ['English', 'en'], ['English (Canada)', 'en-CA'], ['Français', 'fr'], ['Québec', 'fr-CA'] ]

end
