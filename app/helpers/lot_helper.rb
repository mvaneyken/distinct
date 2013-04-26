module LotHelper
  
  def result_class(sample)
    if sample.within_tolerance?
      'success'
    elsif sample.failed?
      'error'
    else
      'warning'
    end
  end
  
  def tolerance(standard)
    "[#{standard.min_tolerance} : #{standard.max_tolerance}]"
  end
  
end