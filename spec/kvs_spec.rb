require_relative File.join('..','lib','kvs')

describe Kvs do
  describe '[]=' do
    subject { Kvs.new[:key] = 'value' }
    it { should eq 'value' }
  end
end
