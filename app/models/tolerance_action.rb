class ToleranceAction < ActiveRecord::Base
  
  COLOURS = [['Red', '#9d2613'], ['Orange', '#f89406'], ['Yellow', '#ffc40d']]
  
  attr_accessible :colour, :message
  
  def colour_action
    "#{colour_name} : #{self.message}"
  end
  
  def colour_name
    match = ''
    COLOURS.each do |shade|
      match = shade[0] if shade[1].eql? self.colour
    end
    match
  end
  
end
