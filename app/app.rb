class HasBeen < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  set :datadir, "config/travellers"
  set :url_template, "http://{traveller}.hasbeen.in/{location}"

  configure :development do
    set :url_template, "http://{traveller}.hasbeen.127.0.0.1.xip.io:9292/{location}"
  end

  configure :test do
    set :datadir, "spec/files"
    set :url_template, "http://{traveller}.hasbeen.test/{location}"
  end
end
