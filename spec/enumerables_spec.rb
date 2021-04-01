require 'enumerables'

describe 'Enumerable' do
  describe '#my_each' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        array = [1, 2, 3, 4, 5]
        expect(array.my_each).to be_a(Enumerable)
      end
    end
    context 'when block is given' do
      it 'should execute the block for each element' do
        before = []
        after = [1, 2, 3, 4, 5]
        after.my_each { |ele| before << ele }
        expect(before).to eq(after)
      end

      it 'should return self with same object id' do
        array = [1, 2, 3]
        expect(array.my_each { |ele| ele }).to be(array)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        array = [1, 2, 3, 4, 5]
        expect(array.my_each_with_index).to be_a(Enumerable)
      end
    end
    context 'when block is given' do
      it 'should execute the block for each element with index' do
        before = {}
        after = { 0 => 'a', 1 => 'b', 2 => 'c' }
        test = %w[a b c]
        test.my_each_with_index { |ele, i| before[i] = ele }
        expect(before).to eq(after)
      end

      it 'should return self with same object id' do
        array = [1, 2, 3]
        expect(array.my_each_with_index { |ele, _i| ele }).to be(array)
      end
    end
  end

  describe '#my_select' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        array = [1, 2, 3, 4, 5]
        expect(array.my_each).to be_a(Enumerable)
      end
    end
    context 'when block is given' do
      it "should return an array after passing each element to block" do
        after = [2,4]
        before = [1,2,3,4]
        expect(before.my_select {|ele| ele.even?}).to eq(after)
      end
      it "should return an an empty array if block condition is false" do
        before = [1,2,3,4]
        expect(before.my_select {|ele|}).to be_empty
      end
    end
  end
end
