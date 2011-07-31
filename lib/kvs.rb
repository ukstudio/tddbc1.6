class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    check_key!(key)
    @records[key] = value
  end

  def [](key)
    check_key!(key)
    @records[key]
  end

  def dump
    @records.map{|k,v| "#{k.inspect},#{v.inspect}" }.join("\n")
  end

  def delete(key)
    check_key!(key)
    @records.delete(key)
  end

  private
  def check_key!(key)
    raise KeyError if key.nil?
  end
end
