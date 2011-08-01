class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    check_key!(key)
    @records[key] = {value: value, date: Time.now}
    @records[key][:value]
  end

  def [](key)
    check_key!(key)
    @records[key].nil? ? nil : @records[key][:value]
  end

  def dump(sec=nil)
    @records.select{|k,hash| sec.nil? ? true : hash[:date].to_i >= (Time.now - sec).to_i}.
             map{|k,hash| "#{k.inspect},#{hash[:value].inspect}" }.reverse.join("\n")
  end

  def delete(key)
    check_key!(key)
    deleted = @records.delete(key)
    deleted.nil? ? nil : deleted[:value]
  end

  def merge(hash)
    check_key!(hash)
    hash.each {|k,v| self[k] = v}
  end

  private
  def check_key!(key)
    if key.is_a?(Hash) ? key.has_key?(nil) : key.nil?
      raise KeyError
    end
  end
end
