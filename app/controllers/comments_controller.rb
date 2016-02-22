class CommentsController < ApplicationController
	def create
		@upload = Upload.find(params[:upload_id])
		@comment = @upload.comments.new(params[:comment].permit(:body))
		@comment.user = current_user
		@comment.save

		redirect_to slide_path(@upload)
	end

	def destroy
		@upload = Upload.find(params[:upload_id])
		@comment = @upload.comments.find(params[:id])
		@comment.destroy

		redirect_to slide_path(@upload)
	end
end
