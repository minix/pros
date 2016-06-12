require 'mini_magick'
#include Magick
include MiniMagick
class Photo < ActiveRecord::Base
#	validates_format_of :content_type, with: /\Aimage\z/, message: "--- Must upload photo"


	def uploaded_photo=(photo_field)
		self.name = base_part_of(photo_field.original_filename)
		self.content_type = photo_field.content_type.chomp
		img = MiniMagick::Image.read(photo_field.read) 
		unless img.nil?
			if self.content_type.chomp == 'png' or self.content_type.chomp == 'gif'
				img.convert("jpg")
			end
			img_original = img_large = img_thumbnail = img
			img_original.strip
			img_original.quality("75%")
			self.original = img_original.to_blob

			img_large.resize("300x200>").strip
			img_large.quality("75%")
			self.large = img_large.to_blob

			img_thumbnail.resize("80x80").strip
			img_thumbnail.quality("75%")
			self.thumbnail = img_thumbnail.to_blob
		end
	end

	def base_part_of(file_name)
		File.basename(file_name).gsub(/[^\w._-]/, '')
	end
	def string_to_binary(value)
		return "data:#{file_type(value)};base64," + Base64.encode64(value)
	end

	private
	def crop_image(image, width, height)
		image.resize(width+'x'+height).strip
		image.quality("75%")
		self.original = image.to_blob
	end
end
