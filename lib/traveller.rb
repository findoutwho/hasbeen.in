# encoding: utf-8

require 'ostruct'
require 'digest/md5'
require 'yaml'

class Traveller < OpenStruct
  def locations
    unless self.hasbeen["cities"].nil?
      self.hasbeen["cities"]
    else
      [] 
    end
  end

  def hasbeen_in?(place)
    self.locations.any?{ |location| 
      location.casecmp(place) == 0 
    }
  end

  def gravatar
    if self.profile && self.profile["gravatar"]
      "http://www.gravatar.com/avatar/#{self.profile["gravatar"]}"
    end
  end
end
