# coding: utf-8
require_relative File.join('..','lib','kvs')

describe Kvs do
  let(:kvs) { Kvs.new }

  describe '[]=' do
    subject { kvs[:key] = 'value' }
    it { should eq 'value' }

    context 'キーにnilを指定した場合' do
      specify do
        expect { kvs[nil] = 'value' }.to raise_error(ArgumentError)
      end
    end

    context 'バリューにnilを指定した場合' do
      before { kvs[:key] = nil }
      subject { kvs }
      its([:key]) { should be_nil }
    end
  end

  describe '[]' do
    context 'まだ何も登録されていない場合' do
      subject { kvs[:key] }
      it { should be_nil }
    end

    context ':keyで値が登録されている場合' do
      before { kvs[:key] = 'value' }
      subject { kvs }
      its([:key]) { should eq 'value' }
    end
  end
end
