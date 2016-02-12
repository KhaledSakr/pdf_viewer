class UploadController < ApplicationController
  
def create
  @upload = Upload.create( upload_params )
end

private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

def upload_params
  params.require(:upload).permit(:document)
end
end
