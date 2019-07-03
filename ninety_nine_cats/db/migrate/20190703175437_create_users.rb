class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string "password_digest", null: false  
      t.string "session_token", null: false
      t.index ["session_token"], name: "index_users_on_session_token", unique: true
      t.timestamps
    end
    add_index :users, :username
  end
end
