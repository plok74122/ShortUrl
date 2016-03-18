class CreateShortUrlLists < ActiveRecord::Migration
  def change
    create_table :short_url_lists do |t|
      t.string :hash , unique: true
      t.string :redirect
      t.integer :count
      t.timestamps null: false
    end
  end
end
