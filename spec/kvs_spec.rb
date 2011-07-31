# coding: utf-8
require_relative File.join('..','lib','kvs')

describe Kvs do
  describe '[]=' do
    subject { Kvs.new[:key] = 'value' }
    it { should eq 'value' }
  end

  describe '[]' do
    context 'まだ何も登録されていない場合' do
      subject { Kvs.new[:key] }
      it { should be_nil }
    end

    context ':keyで値が登録されている場合' do
      before do
        @kvs = Kvs.new
        @kvs[:key] = 'value'
      end
      subject { @kvs }
      its([:key]) { should eq 'value' }
    end
  end
end
