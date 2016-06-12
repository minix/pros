class PhotoController < ApplicationController
	def index

		@photo = Photo.find.order(:id)
	end

	def get
		current_user
		@photo = Photo.new
	end

	def save
		@photo = Photo.new(photo_params)
		if @photo.save
			redirect_to(action: 'show', id: @photo.id, notice: 'Photo has upload.' )
		else
			render(action: 'new')
		end
	end

	def photo
		@photo = Photo.find(params[:id])
		begin
			send_data(@photo.original, filename: @photo.name, type: @photo.content_type, disposition: "inline")
		rescue
			print "Error! "
		end
	end
	def photo_large
		@photo = Photo.find(params[:id])
		send_data(@photo.large, filename: @photo.name, type: @photo.content_type, disposition: "inline")
	end
	def photo_thumbnail
		@photo = Photo.find(params[:id])
		send_data(@photo.thumbnail, filename: @photo.name, type: @photo.content_type, disposition: "inline")
	end

	def show
		@photo = Photo.find(params[:id])
	end

	private
	def photo_params
		params.require(:photo).permit(:comment, :path,:content_type, :large, :thumbnail, :name, :original, :uploaded_photo)
		#params.require(:photo).permit(:comment, :path, { uploaded_photo_attributes: [:content_type, :large, :thumbnail, :name, :original, :comment]})
		#params.require(:photo).permit(:comment, :name, :path, :content_type, :original, :large, :thumbnail, uploaded_photo_attributes: [:content_type, :large, :thumbnail, :name, :original, :comment])
	end
end
