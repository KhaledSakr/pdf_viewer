class UploadController < ApplicationController

  def new
    @upload = Upload.new
  end

	def create
	  @upload = Upload.new(upload_params)
	  if @upload.save
      flash[:success] = "File Successfuly Uploaded"
      redirect_to root_path
    else
      flash[:alert] = "Error saving file"
    	render 'new'
		end
	end

	def show
		@upload = Upload.find(params[:id])
	end	
private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

	def upload_params
	  params.require(:upload).permit(:document)
	end

end
