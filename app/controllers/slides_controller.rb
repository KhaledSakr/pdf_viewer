class SlidesController < ApplicationController
  def new
	end
  
  def index
  	@uploads = Upload.all
  end
  def show
    @upload = Upload.find(params[:id])
    @name = @upload.document_file_name
    @name = @name.partition('.').first 
    @name.sub! '_', ' '
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    redirect_to root_path
  end

  def upvote
    @upload = Upload.find(params[:id])
    @upload.upvote_by current_user
    redirect_to :back
  end
end
