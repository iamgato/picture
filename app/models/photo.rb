require "xmlrpc/client" 

class Photo < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  attr_writer :tag_list, :tags, :taggings, :tag_id, :taggable_id
  
  #before_save :add_istock_tags
  
  searchable do
    text :name
    text :filetype
    text :tags   
  end
  
  def filetype
    image_content_type
  end
  
  
  def add_istock_tags
    tags = self.get_tags_from_istock
    self.tags = tags
  end
  
 # Find the number of tags on each photo for tag cloud
 #Photo.tag_counts_on(:tags)
 
  
 # def self.search(search)
 #   if search
 #     find(:all, :name.matches => ["%#{search}%"])
 #   else
 #     find(:all)
 #   end
 # end

  
  def get_tags_from_istock

  #Trying to not pass a "0" string to the parameters block because it will fail
  # if (self.istock_number == "0")
  # 
  #   # we dont have information about the istock #
  #    
  # else
  #   
  #   # we have information about the istock #
  #   
  # end
  # 
    
    
    #----- Check to see if this has an iStock Number to look for tags. This should definitely be tweaked because some of the file names are pulling down the wrong tags---#
  
      
    #----------Make an object to represent the XML-RPC server.---------#
    @server = XMLRPC::Client.new2("http://api.istockphoto.com/webservices/xmlrpc")
  
    #--------- Parameters passed to istock when server called--------#
  
    
    parameters = {:apiKey=>"bfe63c38e18bcf3c715a52f6", :fileID => self.istock_number}
  
    #---------- Call the remote server and get our result------------#
    result = @server.call("istockphoto.image.getInfo", parameters)
    
      #---- should add rescue if the photo doesn't have istock number = invalid parameter --#

  
    #--------------Output raw XML--------------------------------#
    #render :text => result, :content_type => 'text/xml'
    #@keywords = REXML::Document.new result
    
    #------ split up the tags------#
    doc = Nokogiri::XML(result)
    keywords = doc.xpath('//keywordList').text.split(',')
    keywords
    #@keywords = doc.xpath('//keywordList').text
    #keywords.inspect
  end

  # What I am doing here is trying to see if a photo doesn't have an istock name, allowing it to be saved.  But, I'm passing it bad tags, so this needs to be fixed.
  
  def istock_number
       y = image_file_name.scan(/\d{4,}/)
       if (y == nil || y == 0)
         x = "3967984"
       #image_file_name.scan(/\d{4,}/).first.to_i.to_s
     else
      x = image_file_name.scan(/\d{4,}/).first.to_i.to_s
     end
     
     puts x
     
      return x
  end
  
  def tag
    @tags = Tag.all
  end
  
  # Taggable images
  acts_as_taggable_on :tags
  

  #---------Paperclip Validations -----------#
  # validates_attachment_presence, :images
  # validates_attachement_content_type :images, :content_type => 'image/jpeg', 'application/postscript'
  
  #-------- Paperclip & Formatting -----------#
  has_attached_file :image, :styles => { :thumb => ["90x90#", :jpg],
                                         :small => ["300x300^", :jpg],
                                         :medium => ["380>x380>", :jpg]}
                    #Add this to get the file to download automatically
                    
                    
                    ##--------Configure url where Paperclip accesses photo -----------#
                    #:url => "/:attachment/:id/:style/:basename.:extension",
                    ##--------Configures path where rails stores uploaded files---#
                    #:path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"
                    
                    ##---------Consider adding in validations like this---------#
                    #validates_attachment_presence :mp3
                     # validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
                     # validates_attachment_size :mp3, :less_than => 20.megabytes
  
  attr_protected :image_file_name, :image_content_type, :image_file_size
                  
                  
  
    
  ### Search photos by keywords ###
  #def self.search(search)
    
    #if search
    #  @photos = Photo.where("%#{params[:search]}%")
  #  else
   #   find.all(:order => "created_at desc")
   # end  
  # end
  
  
                       
end
