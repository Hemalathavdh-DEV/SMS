class RenameAuthIdToAuthIdDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :accounts, :auth_id, :auth_id_digest
  end
end
