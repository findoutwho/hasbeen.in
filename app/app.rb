class HasBeen < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  set :datasource, "config/travellers"

  configure :testing do
    set :datasource, "spec/files"
  end
end
