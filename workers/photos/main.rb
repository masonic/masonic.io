require 'dropbox_sdk'

class Datastore
  def initialize
    # TODO auth AWS S3
  end

  def put
    nil
  end
end

class PhotoPool
  def initialize dbx_client
  end

  def each &block
    # TODO access data in folder
    # TODO yield photo
  end

  def remove photo
    # TODO delete from dropbox
  end
end

def get_auth_token_interactive key, secret
  flow = DropboxOAuth2FlowNoRedirect.new(key, secret)
  authorize_url = flow.start()

  # Interactively prompt
  puts '1. Go to: ' + authorize_url
  puts '2. Click "Allow" (you might have to log in first)'
  puts '3. Copy the authorization code'
  print 'Enter the authorization code here: '
  code = gets.strip

  access_token, _ = flow.finish(code)
  return access_token
end

def get_auth_token interactive=false
  if interactive
    # TODO bubble up errors
    key = ENV['DBX_MASONIC_MEMORIES_KEY']
    secret = ENV['DBX_MASONIC_MEMORIES_SECRET']

    while true
      begin
        access_token = get_auth_token_interactive(key, secret)
      rescue DropboxError
        next
      ensure
        return get_auth_token_interactive key, secret
      end
    end

  else
    return ENV['DBX_MASONIC_MEMORIES_DEV_TOKEN']
  end
end

def main

  access_token = get_auth_token


  datastore = Datastore.new

  client = DropboxClient.new(access_token)
  pool = PhotoPool.new(client)
  pool.each do |photo|
    err = datastore.put(photo)
    if err == nil then
      pool.remove(photo)
    else
      # TODO log failure; maybe retry
    end
  end
end

main()
