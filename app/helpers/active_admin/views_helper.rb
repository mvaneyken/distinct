module ActiveAdmin::ViewsHelper
  
  def blank_when_zero(value)
    !value || value.zero? ? '' : value
  end
  
end