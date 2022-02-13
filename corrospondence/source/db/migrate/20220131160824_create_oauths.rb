class CreateOauths < ActiveRecord::Migration[7.0]
  def change
    create_table :oauths do |t|
      t.string :client_id
      t.string :client_secret

      t.timestamps
    end
  end
end
