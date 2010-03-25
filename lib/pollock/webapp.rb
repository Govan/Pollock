#
# Sinatra app to server images.  If the image exists serve it, if it doesn't 
# generate and cache it.
# 

PUBLIC_DIR = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'public')
POLLOCK_PORT = 1912

set :port, POLLOCK_PORT
set :public, PUBLIC_DIR
set :environment, :production

get "/" do
  File.open(File.join(PUBLIC_DIR, 'index.html'))
end

get %r{/placeholders/(.*)} do |image_params|
  image = Pollock::Image.new(image_params)
  File.open(image.save(File.join(PUBLIC_DIR, 'placeholders')))
end