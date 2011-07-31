class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    @records[key] = value
  end

  def [](key)
    @records[key]
  end
end
