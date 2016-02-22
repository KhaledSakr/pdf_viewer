class UploadController < ApplicationController

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.user_id = current_user.id
    if @upload.save

      #Start from here ! 
      @test = @upload.document.url
      @test = @test.partition('?').first
      @path = @upload.document.url
      @path = @path.partition('?').first
      @remove_path = @path.split('/').last
      @path.slice! @remove_path
      
      #To convert pdf to png, pdf is an array has all the pdf pages as images
      pdf = Magick::ImageList.new("public" + @test)
      
      count = pdf.count #count = pdf's number of pages
          
      @file_name = @upload.document_file_name # @file_name = The pdf file name
      @file_name = @file_name.partition('.').first 
      
      #Loop to convert every page for an image
      for i in 0...count
          #before [@file_name + "#{i}.png"] you can edit where to save the images
       png = pdf[i].write("public/"+@path+@file_name + "#{i}.png")
       @page = Page.new
       @page.upload = @upload
       @page.url = @path+@file_name + "#{i}.png"
       @page.save

      end
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
