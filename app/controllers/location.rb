HasBeen.controllers do
  layout :application

  get :index do
    halt 404 unless defined? username
    @traveller = Traveller.find(username.downcase)
    halt 404 if @traveller.nil?
    render "location/overview"
  end

  get :index, :map => "/:location" do
    halt 404 unless defined? username
    @traveller = Traveller.find(username.downcase)
    halt 404 if @traveller.nil?
    @location = escape_html(params[:location].force_encoding("UTF-8"))
    if @traveller.hasbeen_in?(@location)
      @verb = "has"
    else
      @verb = "hasn't"
      status 404
    end
    render "location/map"
  end

end
