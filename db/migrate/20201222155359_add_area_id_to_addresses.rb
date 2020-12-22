class AddAreaIdToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :area_id, :integer
  end
end
