require_relative File.join('..','lib','kvs')

describe Kvs do
  describe '[]=' do
    subject { Kvs.new[:key] = 'value' }
    it { should eq 'value' }
  end

  describe '[]' do
    subject { Kvs.new[:key] }
    it { should be_nil }
  end
end
