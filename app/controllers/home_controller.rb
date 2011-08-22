###########Currently this scaffold is not used##############


class HomeController < ApplicationController
  
  def index
    @upload = Upload.new
  end
end