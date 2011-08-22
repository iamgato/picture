
class IstocksController < ApplicationController
  
  require "xmlrpc/client" 
  
  def index
    

      #find photo
      @photo = Photo.find(params[:id])
      # get photo file name
      image_file_name = @photo.image_file_name
      #pull out image_file_name_number
      

      doc = @photo.get_tags_from_istock
       render :text => doc  
  end
 end   
