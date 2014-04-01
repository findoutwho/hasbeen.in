class Location < String
  attr_accessor :hint

  def geo_data
    geo = GoogleMapsGeocoder.new(hint || self)
    { name: self, lat: geo.lat, lng: geo.lng }
  end

end
