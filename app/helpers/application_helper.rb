module ApplicationHelper
  def error_messages_for(object, css_class: "bg-red-50 border border-red-300 text-red-800 rounded-lg p-4 mt-4 text-sm")
    return "".html_safe if object.errors.empty?

    content_tag :div, class: css_class do
      content_tag(:p, "Please fix the following errors:", class: "font-semibold mb-2") +
      content_tag(:ul, class: "list-disc list-inside space-y-1") do
        object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
      end
    end
  end
end
