class AddAppTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :app_tokens do |t|
      t.text :mfb_token
      t.text :mfb_refresh_token
      t.integer :mfb_token_expires_at
      t.text :mfb_client_id
      t.text :mfb_client_secret
      t.integer :singleton_guard

    end
    add_index(:app_tokens, :singleton_guard, unique: true)
  end
end
