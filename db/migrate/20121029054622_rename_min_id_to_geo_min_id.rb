class RenameMinIdToGeoMinId < ActiveRecord::Migration
  def change
    rename_table :min_ids, :geo_min_ids
  end
end
