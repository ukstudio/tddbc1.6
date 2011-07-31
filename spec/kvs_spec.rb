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

    context 'キーにnilを指定した場合' do
      specify do
        expect { kvs[nil] }.to raise_error(KeyError)
      end
    end
  end

  describe '#dump' do
    subject { kvs.dump }

    context '空の場合' do
      it { should eq '' }
    end

    context 'キーとバリューが2セット登録されている場合' do
      before do
        kvs[:key] = 'value'
        kvs[:key2] = 'value2'
      end
      it { should eq %Q!:key,"value"\n:key2,"value2"! }
    end
  end

  describe '#delete' do
    context '存在しないキーを指定した場合' do
      subject { kvs.delete(:nonexists) }
      it { should be_nil }
    end

    context '存在するキーを指定した場合' do
      before do
        kvs[:key] = 'value'
        @deleted_value = kvs.delete(:key)
      end
      subject { kvs }
      its([:key]) { should be_nil }
      specify { @deleted_value.should eq 'value' }
    end
  end
end
