class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :site
      t.string :url

      t.timestamps
    end
  end
end
