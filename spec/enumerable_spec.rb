require_relative '../lib/enumerable'

RSpec.describe Enumerable do
  let(:a) {[5, 3, 2, 4]}
  let(:range) {Range.new(5..10)}
  let(:words) {%w[dog door rod blade]}
  let(:block) { proc { |num| num < 4 }}

  describe '#my_each' do
    it 'should returns an Enumerator when no block given' do
      expect(a.my_each.is_a?(Enumerator)).to be_truthy
    end

    it 'should return the original array' do
      expect(words.my_each {|e| e}) .to eq(words)
    end

    it 'prints result to stdout from block calculation' do
      expect { a.my_each { |i| print i * 4 } }.to output(/2012816/).to_stdout
    end

    it 'prints result to stdout from block calculation' do
      expect { words.my_each { |i| print i.length } }.to output(/3435/).to_stdout
    end
  end

  describe '#my_each_with_index' do
    it 'should returns an Enumerator when no block given' do
      expect(a.my_each_with_index.is_a?(Enumerator)).to be_truthy
    end

    it 'prints the element and corresponding index at stdout' do
      expect { a.my_each_with_index { |el, i| print el, i }}.to output(/50312243/).to_stdout
    end

    it 'returns original array when no output' do
      expect(a.my_each_with_index { block }).to eq(a)
    end
  end

  describe '#my_select' do
    it 'should returns an Enumerator when no block given' do
      expect(a.my_select.is_a?(Enumerator)).to be_truthy
    end

    it 'returns even numbers from array of numbers' do
      expect(a.my_select(&:even?)).to eq([2, 4])
    end

    it 'should return a new array where the elements are elements of the original array where the block resulted in true' do
      expect(a.my_select(&block)).to eq([3, 2])
    end
  end

  describe '#my_all?' do
    it 'should return true' do
      expect(a.my_all?(&:odd?)).to be_falsy
    end

    it 'should return false' do
      expect(a.my_all? { |n| n < 10 }).to be_truthy
    end
  end

  describe '#my_any?' do
  it 'should return true' do
    expect(a.my_any?(&:odd?)).to be_truthy
  end

  it 'should return false' do
    expect(a.my_any? { |n| n > 10 }).to be_falsy
  end
  end


end
