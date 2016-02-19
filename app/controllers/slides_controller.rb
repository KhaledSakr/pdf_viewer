class SlidesController < ApplicationController

  def new
  	@uploads = Upload.all
  end

  def show
    @upload = Upload.find(params[:id])
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
