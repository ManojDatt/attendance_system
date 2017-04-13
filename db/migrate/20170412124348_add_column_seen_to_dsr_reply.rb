class AddColumnSeenToDsrReply < ActiveRecord::Migration[5.0]
  def change
    add_column :dsr_replies, :seen, :boolean, default: false
  end
end
