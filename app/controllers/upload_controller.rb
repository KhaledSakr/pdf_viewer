class UploadController < ApplicationController

  def show
    @upload = Upload.find_by_id(:id)
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      log_in @upload
      flash[:success] = "You have successfuly uploaded a file!"
      redirect_to upload_path
    else
      render 'new'
    end
  end
	
private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

	def upload_params
	  params.require(:upload).permit(:document)
	end

end
