module ApplicationHelper
  
  def zero_blank(number)
    number == 0 ? '' : number_to_human(number)
  end
  
  def render_flash_message(message)
    return if message.blank?

    if message.is_a?(Array)
      content_tag(:ul) do
        message.each do |m|
          concat content_tag(:li, m)
        end
      end
    else
      content_tag(:p, message)
    end
  end
  
end
