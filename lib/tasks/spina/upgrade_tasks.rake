namespace :spina do

  task convert_page_parts_to_json: :environment do
    Spina.config.locales.each do |locale|
      I18n.with_locale(locale) do
        Spina::Page.all.each do |page|
          page_parts = Spina::PagePart.where(page_id: page.id)
          json_content = page_parts.map do |page_part|
            next if page_part.partable.nil? # Skip blank page parts

            json_part = if page_part.partable.respond_to?(:convert_to_json!)
              page_part.convert_to_json!
            else
              puts "#{page_part.name} (#{page_part.page_partable_type}) does not convert to JSON yet. Implement it first."
              nil
            end
          end.compact

          page.update("#{locale}_content".to_sym => json_content)
        end
      end
    end
  end

  task photo_to_image: :environment do
    bar = ProgressBar.create title: "Photos", total: Spina::Photo.where(image_id: nil).count
    Spina::Photo.where(image_id: nil).find_each do |photo|
      image = Spina::Image.create(media_folder_id: photo.media_folder_id)
      begin
        image.file.attach(io: photo.file.sanitized_file.file, filename: photo.name)
        photo.update_column(:image_id, image.id)
      rescue Errno::ENOENT
        image.destroy
      end
      bar.increment
    end

    bar = ProgressBar.create title: "PageParts", total: Spina::PagePart.where(page_partable_type: 'Spina::Photo').count
    Spina::PagePart.where(page_partable_type: 'Spina::Photo').find_each do |page_part|
      if page_part.page_partable.present?
        page_part.update_columns(
          page_partable_type: 'Spina::Image',
          page_partable_id: page_part.page_partable.image_id
        )
      else
        page_part.update_column(:page_partable_type, 'Spina::Image')
      end
      bar.increment
    end

    bar = ProgressBar.create title: "StructureParts", total: Spina::StructurePart.where(structure_partable_type: 'Spina::Photo').count
    Spina::StructurePart.where(structure_partable_type: 'Spina::Photo').find_each do |structure_part|
      if structure_part.structure_partable.present?
        structure_part.update_columns(
          structure_partable_type: 'Spina::Image',
          structure_partable_id: structure_part.structure_partable.image_id
        )
      else
        structure_part.update_column(:structure_partable_type, 'Spina::Image')
      end
      bar.increment
    end

    bar = ProgressBar.create title: "PhotoCollections", total: Spina::PagePart.where(page_partable_type: 'Spina::PhotoCollection').count
    Spina::PagePart.where(page_partable_type: 'Spina::PhotoCollection').find_each do |page_part|
      if page_part.partable.present?
        image_collection = Spina::ImageCollection.create
        page_part.partable.photos.each do |photo|
          image_collection.images << Spina::Image.find(photo.image_id)
        end
        page_part.update_columns(
          page_partable_type: 'Spina::ImageCollection',
          page_partable_id: image_collection.id
        )
      else
        page_part.update_column :page_partable_type, 'Spina::ImageCollection'
      end
      bar.increment
    end

    bar = ProgressBar.create title: "StructurePart PhotoCollections", total: Spina::StructurePart.where(structure_partable_type: 'Spina::PhotoCollection').count
    Spina::StructurePart.where(structure_partable_type: 'Spina::PhotoCollection').find_each do |structure_part|
      if structure_part.partable.present?
        image_collection = Spina::ImageCollection.create
        structure_part.partable.photos.each do |photo|
          image_collection.images << Spina::Image.find(photo.image_id)
        end
        structure_part.update_columns(
          structure_partable_type: 'Spina::ImageCollection',
          structure_partable_id: image_collection.id
        )
      else
        structure_part.update_column :structure_partable_type, 'Spina::PhotoCollection'
      end
      bar.increment
    end
  end
end
