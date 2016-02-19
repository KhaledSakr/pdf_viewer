class UploadController < ApplicationController

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      log_in @upload
      flash[:success] = "You have successfuly uploaded a file!"
      redirect_to slides_path
    else
      render 'new'
    end
  end
	
  def show
    @upload = Upload.find(params[:id])
  end

  def destroy
    @upload = upload.find(params[:id])
    @upload.destroy

    redirect_to root_path
  end

  def upvote
    @upload = Upload.find(params[:id])
    @upload.upvote_by current_user
    redirect_to :back
  end
private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

	def upload_params
	  params.require(:upload).permit(:document)
	end

end
