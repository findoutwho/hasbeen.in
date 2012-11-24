# Helper methods defined here can be accessed in any controller or view in the application

HasBeen.helpers do

  def format_locations(locations)
    links = locations.collect do |location|
      location = escape_html(location)
      link_to(location, url_for(:index, :location => location))
    end

    case
    when links.length < 1 
      "no locations yet."
    when links.length == 1 
      links[0]
    when links.length == 2
      "#{links[0]} and #{links[1]}"
    when links.length > 2
      first = links[0, links.length - 1].join(", ")
      last  = links[links.length - 1]
      "#{first} and #{last}"
    end
  end

  def username
    sub = request.host.match(/([A-z0-9]+).hasbeen.(dev|in)$/)
    sub[1].downcase if defined? sub[1]
  end

  private

  def parsed_uri
    Addressable::URI.parse( request.url )
  end

end
