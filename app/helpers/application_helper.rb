module ApplicationHelper

  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks, :underline, :highlight,
               :no_images, :safe_links_only, :prettify, :no_styles]
    Markdown.new(text, *options).to_html.html_safe
  end
end