class TagsController < ApplicationController
  
  def index
    @tags = Tag.all
  end
  
  def tagged_with
  end
  
  def show
    @tag = Tag.find(params[:id])
    #@photos = Photo.find.tagged_with(@tag)
  end

  
end

