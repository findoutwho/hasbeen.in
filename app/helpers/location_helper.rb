# Helper methods defined here can be accessed in any controller or view in the application
require 'addressable/template'

HasBeen.helpers do
  def format_travellers(travellers)
    links = travellers.collect do |traveller|
      template = Addressable::Template.new(HasBeen.url_template)
      link_to(
        traveller.name,
        template.expand({:traveller => traveller.username})
      )
    end

    links.to_sentence(:last_word_connector => " and ")
  end

  def format_locations(locations)
    links = locations.collect do |location|
      location = escape_html(location)
      link_to(location, url_for(:index, :location => location))
    end

    if links.length == 0
      "no locations yet"
    else
      links.to_sentence(:last_word_connector => " and ")
    end
  end

  def username
    sub = request.host.match(/([A-z0-9]+).hasbeen.(dev|in|test)$/)
    sub[1].downcase if defined? sub[1]
  end

  private

  def parsed_uri
    Addressable::URI.parse( request.url )
  end

  def join_us_link
    '<p class="mini muted pull-right"><small>Join hasbeen.in at <a href="https://github.com/bascht/hasbeen.in">Github</a>!</small></p>'
  end
end
