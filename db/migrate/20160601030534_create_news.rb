class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :content
      t.string :comment

      t.timestamps null: false
    end
  end
end
