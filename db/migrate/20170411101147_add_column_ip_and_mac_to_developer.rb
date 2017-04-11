class AddColumnIpAndMacToDeveloper < ActiveRecord::Migration[5.0]
  def change
  	add_column :developers, :sign_in_mac, :macaddr
  end
end
