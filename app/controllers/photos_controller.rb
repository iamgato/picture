class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.xml
 
 
   def index
  #   @photos = if params[:q].blank?
  #     Photo.all(:order => "created_at desc").paginate(:page => params[:page], :per_page => 100)
  #    else
  #      Product.solr_search do |s|
  #        s.keywords params [:q]
  #      end
  #    end
  #  end
     
     
     if params[:search]
       @search = Photo.search do
          fulltext params[:search]
        end
       @photos = @search.results.paginate(:page => params[:page], :per_page => 100)
    else
       @photos = Photo.all(:order => "created_at desc").paginate(:page => params[:page], :per_page => 100)
    end
   end
 
  #def index
  #  @photos = Photo.all #search(params[:search])
  #end

  def show
    @photo = Photo.find(params[:id])
     
  end

  def new
    @photo = Photo.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

 
  def create
    @photo = Photo.new(params[:photo])
    
    respond_to do |format|
      if @photo.save
        format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice => 'Photo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
  
  #---------- iStock Controller --------------#
  
  require "xmlrpc/client" 

   # Tag Cloud
   def tag_cloud
       @tags = Photo.tag_counts_on(:tags)
    end
   
  #def download
  #  @photo = Photo.find(params[:id])
  #  send_file '/images/@photo./original/iStock_000000058748Small.jpg'
  #
  # end
   
    
end

