class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    raise ArgumentError if key.nil?
    @records[key] = value
  end

  def [](key)
    raise KeyError if key.nil?
    @records[key]
  end

  def dump
    @records.map{|k,v| "#{k.inspect},#{v.inspect}" }.join("\n")
  end
end
