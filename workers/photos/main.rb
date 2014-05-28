
class Datastore
  def initialize
    # TODO auth AWS S3
  end

  def put
    nil
  end
end

class PhotoPool
  def initialize
    # TODO authenticate dropbox api
  end

  def each &block
    # TODO access data in folder
    # TODO yield photo
  end

  def remove photo
    # TODO delete from dropbox
  end
end

def main

  key = ENV['DBX_MASONIC_MEMORIES_KEY']
  secret = ENV['DBX_MASONIC_MEMORIES_SECRET']

  datastore = Datastore.new

  pool = PhotoPool.new
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
