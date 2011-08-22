###########Currently this scaffold is not used##############
class SearchController < ApplicationController
  def search
    Photo.find_each(:batch_size => 2000) do |photo|
    end
  end
end
