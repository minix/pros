class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :comment
      t.string :name
      t.string :path
      t.string :content_type
      t.binary :original, :limit => 1.megabyte, :null => false
      t.binary :large
      t.binary :thumbnail

      t.timestamps null: false
    end
  end
end
