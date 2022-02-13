class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations, id: :uuid do |t|
      t.string :topic
      t.string :summary
      t.uuid :forum_id
      t.string :content_owner_id

      t.timestamps
    end

    add_index :conversations, :content_owner_id
  end
end
