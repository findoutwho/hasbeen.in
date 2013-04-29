# encoding: utf-8

require 'ostruct'
require 'digest/md5'
require 'yaml'

class Traveller < OpenStruct
  def locations
    unless self.hasbeen["cities"].nil?
      self.hasbeen["cities"].collect do |city|
        if city.kind_of? Hash
          location = Location.new(city.keys.first)
          location.hint = String.new(city.values.first)
        else
          location = Location.new(city.to_s)
        end
        location
      end
    else
      []
    end
  end

  def hasbeen_in?(place)
    self.locations.any?{ |location|
      location.casecmp(place) == 0
    }
  end

  def find_location(location)
    self.locations.grep(location).first
  end

  def gravatar
    if self.profile && self.profile["gravatar"]
      "http://www.gravatar.com/avatar/#{self.profile["gravatar"]}"
    end
  end
end
