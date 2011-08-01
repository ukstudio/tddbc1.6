class Kvs
  def initialize
    @records = {}
  end

  def []=(key,value)
    check_key!(key)
    @records[key] = {value: value, timestamp: Time.now.to_i}
    @records[key][:value]
  end

  def [](key)
    check_key!(key)
    @records[key].nil? ? nil : @records[key][:value]
  end

  def dump(sec=nil)
    @records.select{|k,record| sec.nil? ? true : recent?(sec,record) }.
             map{|k,record| record_inspect(k,record) }.
             reverse.join("\n")
  end

  def delete(key)
    check_key!(key)
    deleted = @records.delete(key)
    deleted.nil? ? nil : deleted[:value]
  end

  def delete_older(sec)
    @records.select{|k,record| !recent?(sec,record) }.
             each{|k,record| delete(k) }
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

  def record_inspect(key,record)
    "#{key.inspect},#{record[:value].inspect}"
  end

  def recent?(sec,record)
    record[:timestamp] >= (Time.now - sec).to_i
  end
end
