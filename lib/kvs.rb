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

  def merge(hash)
    check_key!(hash)
    @records.merge!(hash)
  end

  private
  def check_key!(key)
    if key.is_a?(Hash) ? key.has_key?(nil) : key.nil?
      raise KeyError
    end
  end
end
