class AddDefaultActiveValueToUrl < ActiveRecord::Migration[6.0]
  def change
    change_column :urls, :active, :boolean, :default => true
  end
end
