require_relative '../lib/enumerable'

RSpec.describe Enumerable do
  let(:a) {[5, 3, 2, 4]}
  let(:range) {(1..8)}
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

  describe '#my_none?' do
    it 'should return false' do
      expect(a.my_none?(&:odd?)).to be_falsy
    end
  
    it 'should return true' do
      expect(a.my_none? { |n| n > 10 }).to be_truthy
    end

    it 'should return false' do
      expect([true,false,nil].my_none?).to be_falsy
    end

    it 'should return true' do
      expect([].my_none?).to be_truthy
    end

    it 'should return true' do
      expect(words.my_none?(/x/)).to be_truthy
    end

    it 'should return false' do
      expect(words.my_none?(/d/)).to be_falsy
    end

  end

  describe '#my_count?' do
    it 'should return the total no of elements in the array' do
      expect(a.my_count).to eq(4)
    end

    it 'should return the total of odd elements in the array' do
      expect(a.my_count(&:odd?)).to eq(2)
    end

    it 'returns array length when no block given' do
      expect(words.my_count).to eq(4)
    end

    it 'returns the number of items that match the positional argument given' do 
      expect(words.my_count('rod')).to eq(1)
    end
  end

  describe '#my_map' do

    it 'returns a modified array resulting from block operation' do
      expect(a.my_map { |n| 2 * n }).to eq([10, 6, 4, 8])
    end

    it 'returns modified array when given a range with a block' do
      expect(range.my_map { |n| n+2}).to eq([3,4,5,6,7,8,9,10])
    end
    
    it 'returns array of strings when given array of integers' do
      expect(a.my_map(&:to_s)).to eq(['5', '3', '2', '4'])
    end

  end

  describe '#my_inject' do

    it 'returns the accumulative result when given a starting value and a block operation' do
      expect(a.my_inject(1) { |product, n| product * n }).to eq(120)
    end

    it 'returns the accumulative result when given starting value and a urnary operator' do
      expect(range.my_inject(1, :*)).to eq(40320)
    end

   
  end

end


