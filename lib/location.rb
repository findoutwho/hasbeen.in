class Location < String
  attr_accessor :hint, :special

  def geo_data
    geo = GoogleMapsGeocoder.new(hint || self)
    { name: self, lat: geo.lat, lng: geo.lng, special: self.special }
  end

end
