class CreateForums < ActiveRecord::Migration[7.0]
  def change
    create_table :forums, id: :uuid do |t|
      t.string :title
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
