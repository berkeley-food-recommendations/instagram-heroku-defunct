class ChangeDatum < ActiveRecord::Migration
  def change
    change_column :data, :data, :text
  end
end
