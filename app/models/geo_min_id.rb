class GeoMinId < ActiveRecord::Base
  attr_accessible :minid, :geo_id

  def update data
    self.minid = data.map { |datum| datum['id'].to_i }.min
    save
  end
end
