class PageController < ApplicationController

def list
    @pages=Page.where(upload_id: params[:id])
  end

def show
    @page=Page.find(params[:id])
  end

end
