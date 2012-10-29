class AddGeoIdToMinId < ActiveRecord::Migration
  def change
    add_column :min_ids, :geo_id, :string
  end
end
