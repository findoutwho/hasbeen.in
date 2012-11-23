require 'ostruct'
require 'digest/md5'
require 'yaml'
require 'pry'

class Traveller < OpenStruct

  def self.find(id, dir = "/Users/bascht/Documents/Code/hasbeen/config/travellers")
    source = File.join(dir, "#{id}.yml")

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
    email = self.profile["email"].downcase
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end
end
