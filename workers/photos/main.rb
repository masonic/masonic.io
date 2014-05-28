require 'aws-sdk'
require 'dropbox_sdk'
require 'pathname'
require 'uuid'

def main

  datastore = Datastore.new

  # TODO bubble up errors
  key = ENV['DBX_MASONIC_MEMORIES_KEY']
  secret = ENV['DBX_MASONIC_MEMORIES_SECRET']
  access_token = get_auth_token(key, secret)

  client = DropboxClient.new(access_token)
  pool = PhotoPool.new(client)

  pool.each do |photo, path|
    err = datastore.put(path, photo)
    if err == nil then
      pool.remove(path)
    else
      # TODO log failure; maybe retry
    end
  end
end

class Datastore
  def initialize
    @s3 = AWS::S3.new
    # TODO auth AWS S3
    # TODO pass in config info (bucket, etc.)
    @uuid_generator = UUID.new
    bucket_name = "masonic-memories-dev"
    @bucket = @s3.buckets[bucket_name]
  end

  def put path, blob
    key = "#{@uuid_generator.generate}-#{Pathname.new(path).basename}"
    object = @bucket.objects.create(key, blob, :acl => :public_read)
    nil
  end
end

class PhotoPool
  def initialize dbx_client
    @client = dbx_client
  end

  # TODO recursively traverse
  def each &block

    # TODO extract and wrap client, item so this class doesn't know about the
    # internals of the Dropbox data structures. Differentiate between files and
    # directories for ease of recursive traversal.


    @client.metadata('/')['contents'].each do |item|
      unless item['is_dir']
        path = item['path']
        contents = @client.get_file(path)
        # TODO only yield if mime type is that of supported image type
        # TODO return only a minimal, useful subset of metadata
        yield(contents, path)
      end
    end
  end

  def remove photo_id
    #@client.file_delete(photo_id)
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

def get_auth_token key, secret, interactive=false
  if interactive

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

main()
