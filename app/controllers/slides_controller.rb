class SlidesController < ApplicationController
  def new
	end
	

	
  def index
  	@uploads = Upload.all
  end
  def show

    @upload = Upload.find(params[:id])
    
    #Start from here ! 
    @test = @upload.document.url
    @test = @test.partition('?').first
    
    #To convert pdf to png, pdf is an array has all the pdf pages as images
    pdf = Magick::ImageList.new("public" + @test)
    
    count = pdf.count #count = pdf's number of pages
        
    @file_name = @upload.document_file_name # @file_name = The pdf file name
    @file_name = @file_name.partition('.').first 
    
    #Loop to convert every page for an image
    for i in 0...count
        #before [@file_name + "#{i}.png"] you can edit where to save the images
      png = pdf[i].write(@file_name + "#{i}.png") 
    end
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
