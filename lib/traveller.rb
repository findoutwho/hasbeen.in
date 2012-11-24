# encoding: utf-8

require 'ostruct'
require 'digest/md5'
require 'yaml'

class Traveller < OpenStruct

  def self.find(id)
    source = File.join(HasBeen.datadir, "#{id}.yml")

    if File.exist? source
      tree = YAML.load(File.read source)
      Traveller.new(tree) if tree.kind_of? Hash
    end
  end

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
    if self.profile && self.profile["email"]
      hash = Digest::MD5.hexdigest(self.profile["email"])
      "http://www.gravatar.com/avatar/#{hash}"
    end
  end
end
