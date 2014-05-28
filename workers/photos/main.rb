
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

  pool = PhotoPool.new
  datastore = Datastore.new

  pool.each do |photo|
    err = datastore.put(photo)
    if err == nil then
      pool.remove(photo)
    else
      # TODO maybe retry
    end
  end
end

main()
