# coding: utf-8
require_relative File.join('..','lib','kvs')

describe Kvs do
  let(:kvs) { Kvs.new }

  describe '[]=' do
    subject { kvs[:key] = 'value' }
    it { should eq 'value' }

    context 'キーにnilを指定した場合' do
      specify do
        expect { kvs[nil] = 'value' }.to raise_error(KeyError)
      end
    end

    context 'バリューにnilを指定した場合' do
      before { kvs[:key] = nil }
      subject { kvs }
      its([:key]) { should be_nil }
    end

    context '既存の値を上書き' do
      before do
        kvs[:key] = 'value'
        kvs[:key] = 'updated_value'
      end
      subject { kvs }
      its([:key]) { should eq 'updated_value' }
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
      it { should eq %Q!:key2,"value2"\n:key,"value"! }
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

    context 'キーにnilを指定した場合' do
      specify do
        expect { kvs.delete(nil) }.to raise_error(KeyError)
      end
    end
  end

  describe '#merge' do
    before do
      kvs.merge(key1: 'value1', key2: 'value2')
    end
    subject { kvs }
    its([:key1]) { should eq 'value1' }
    its([:key2]) { should eq 'value2' }

    context '登録されているキーが指定された場合' do
      before do
        kvs.merge(key1: 'updated_value1')
      end
      its([:key1]) { should eq 'updated_value1' }
    end

    context '引数のキーが重複していた場合' do
      before do
        kvs.merge(key1: 'before', key1: 'after')
      end
      its([:key1]) { should eq 'after' }
    end

    context '引数のキーにnilが含まれていた場合' do
      specify do
        expect { kvs.merge(nil => 'nil') }.to raise_error(KeyError)
      end
    end
  end
end
