class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string      :post_number,    null: false
      t.integer     :area_id,        null: false
      t.string      :municipality,   null: false
      t.string      :address,        null: false
      t.string      :building
      t.string      :phone,          null: false
      t.references  :purchase,       foreign_key: true
      t.timestamps
    end
  end
end
