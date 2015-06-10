require ::File.expand_path('../config/app_config',  __FILE__)
require ::File.expand_path('../app/app',  __FILE__)

run Sinatra::Application
