class Datum < ActiveRecord::Base
  attr_accessible :data

  def self.store_all data
    data.each do |datum|
      Datum.create :data => datum
    end
  end
end
