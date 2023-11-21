class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :auth_id
      t.string :username, limit: 30

      t.timestamps
    end
  end
end
