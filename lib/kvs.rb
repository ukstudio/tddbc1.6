class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    raise ArgumentError if key.nil?
    @records[key] = value
  end

  def [](key)
    @records[key]
  end
end
