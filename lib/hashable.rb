module Hashable
  
  def to_data_hash
    data_hash = self.attributes
    data_hash.delete('id')
    data_hash.delete('created_at')
    data_hash.delete('updated_at')
    data_hash
  end
  
end