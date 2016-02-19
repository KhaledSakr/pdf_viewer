class CommentsController < ApplicationController
	
	def create
		@upload = Upload.find(params[:upload_id])
		@comment = @upload.comments.create(params[:comment].permit(:name, :body))
		redirect_to slide_path(@upload)
	end

	def destroy
		@upload = Upload.find(params[:upload_id])
		@comment = @upload.comments.find(params[:id])
		@comment.destroy
		redirect_to slide_path(@upload)
	end

end
