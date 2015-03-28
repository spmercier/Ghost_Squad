class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
		t.string :provider
		t.string :uid
		t.string :user_id
		t.string :consumer_key
		t.string :consumer_secret
		t.string :token
		t.string :secret
		t.timestamps null: false
		end
    end
end