class PageController < ApplicationController

def list
    @pages=Page.where(upload_id: params[:upload_id])
  end

def show
    @page=Page.find(params[:id])
  end

end
