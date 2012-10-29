class CreateMinIds < ActiveRecord::Migration
  def change
    create_table :min_ids do |t|
      t.string :minid

      t.timestamps
    end
  end
end
