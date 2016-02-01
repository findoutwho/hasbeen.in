HasBeen.controllers do

  CACHE_SECONDS = 2505600 # 29 days

  layout :application

  register Padrino::Cache  # includes helpers
  enable :caching          # turns on caching

  get :index do
    case username
    when nil
      uri = parsed_uri()
      uri.host.sub!(/^www./, '')
      redirect uri.to_s
    when "www"
      @travellers = Travellers.find_all
      render "index"
    else
      @traveller = Travellers.find(username)
      halt 404 if @traveller.nil?
      render "location/overview"
    end
  end

  get :locations_json, map: '/locations.json' do
    halt 404 unless defined? username
    @traveller = Travellers.find(username)
    halt 404 if @traveller.nil?
    content_type :json
    locations = @traveller.locations.collect do |location|
      begin
        content_from_cache = cache("location_#{location}", :expires_in => CACHE_SECONDS) do
          location.geo_data.to_json
        end
        JSON.parse(content_from_cache)
      rescue RuntimeError => e
      end
    end
    if @traveller.current_hometown
      locations << JSON.parse(@traveller.current_hometown.geo_data.to_json)
    end
    { locations: locations.delete_if(&:nil?) }.to_json
  end

  get :index, :map => "/:location" do
    halt 404 unless defined? username
    @traveller = Travellers.find(username)
    halt 404 if @traveller.nil?

    location = CGI.unescapeHTML(params[:location].force_encoding("UTF-8"))

    if @traveller.hasbeen_in?(location)
      @location = @traveller.find_location(location) || @traveller.current_hometown
      @verb = "has"
    else
      @location = Location.new(location)
      @verb = "hasn't"
      status 404
    end
    render "location/map"
  end

end
