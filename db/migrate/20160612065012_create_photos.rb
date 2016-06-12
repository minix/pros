class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
	  t.string :command
      t.string :name
      t.string :path
      t.string :content_type
      t.binary :original
      t.binary :large, null: false
      t.binary :thumbnail

      t.timestamps null: false
    end
  end
end
