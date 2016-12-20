module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    # => used to build the html and css to dosplay the form element and any associated errors
    content_tag :div, capture(&block), class: css_class
  end


  def markdown(content)
       renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
       options = {
           autolink: true,
           no_intra_emphasis: true,
           disable_indented_code_blocks: true,
           fenced_code_blocks: true,
           tables: true,
           lax_html_blocks: true,
           strikethrough: true,
           superscript: true
       }
       Redcarpet::Markdown.new(renderer, options).render(content).html_safe
   end


end
