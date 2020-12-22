class RemovePrefectureToAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :prefecture, :string
  end
end
