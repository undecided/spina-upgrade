class CreateSpinaUpgradeMigration < ActiveRecord::Migration[5.2]

  def up
    unless column_exists? :spina_photos, :image_id
      add_column :spina_photos, :image_id, :integer, foreign_key: { to_table: :spina_images }
    end
  end

  def down
    if column_exists? :spina_photos, :image_id
      remove_column :spina_photos, :image_id
    end
  end

end