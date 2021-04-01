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
      it 'should return an array after passing each element to block' do
        after = [2, 4]
        before = [1, 2, 3, 4]
        expect(before.my_select(&:even?)).to eq(after)
      end
      it 'should return an an empty array if block condition is false' do
        before = [1, 2, 3, 4]
        expect(before.my_select { false }).to be_empty
      end
    end
  end

  describe '#my_all?' do
    context 'when block is given' do
      it 'should return true if all elements in block returns true' do
        expect([1, 2, 3, 4].my_all? { |ele| ele.is_a?(Integer) }).to be true
      end

      it 'should return false if any elements in block returns false' do
        expect([1, 2, 3, 'S'].my_all? { |ele| ele.is_a?(Integer) }).to be false
      end
    end
    context 'when paramer is given' do
      it 'should return true if all elements match Class parameter' do
        expect([1, 2, 3, 4].my_all?(Integer)).to be true
      end

      it 'should return true if all elements match Regex' do
        expect(%w[a b c d].my_all?(/[abcd]/)).to be true
      end

      it 'should return true if all elements match other any paramter' do
        expect([1, 1, 1, 1].my_all?(1)).to be true
      end

      it 'should return false if any elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_all?(Integer)).to be false
      end

      it 'should return true if all elements are truthy' do
        expect([1, 'a', 1.4].my_all?).to be true
      end

      it 'should return true if empty' do
        expect([].my_all?).to be true
      end
    end
  end

  describe "#my_any?" do
    context 'when block is given' do
      it 'should return true if any elements in block returns true' do
        expect([1, 2, 3, 4].my_any? { |ele| ele.is_a?(Integer) }).to be true
      end

      it 'should return false if all elements in block returns false' do
        expect([1, 2, 3, 4].my_any? { |ele| ele.is_a?(String) }).to be false
      end
    end
    context 'when paramer is given' do
      it 'should return true if any elements match Class parameter' do
        expect([1, 2, 3, "s"].my_any?(String)).to be true
      end

      it 'should return true if any elements match Regex' do
        expect(%w[a b c d].my_any?(/[abcd]/)).to be true
      end

      it 'should return true if any elements match other any paramter' do
        expect([1, 1, 1, 2].my_any?(2)).to be true
      end

      it 'should return false if all elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_any?(Float)).to be false
      end

      it 'should return true if any elements are truthy' do
        expect([1,nil , 1.4].my_any?).to be true
      end

      it 'should return false if empty' do
        expect([].my_any?).to be false
      end
    end
  end

  describe "#my_none?" do
     context 'when block is given' do
      it 'should return true if none of the elements in block returns true' do
        expect([1, 2, 3, 4].my_none? { |ele| ele.is_a?(String) }).to be true
      end

      it 'should return false if all elements in block returns true' do
        expect([1, 2, 3, 4].my_none? { |ele| ele.is_a?(Integer) }).to be false
      end
    end
    context 'when paramer is given' do
      it 'should return true if no elements match Class parameter' do
        expect([1, 2, 3, "s"].my_none?(Float)).to be true
      end

      it 'should return true if no elements match Regex' do
        expect(%w[e f g h].my_none?(/[abcd]/)).to be true
      end

      it 'should return true if no elements match other none paramter' do
        expect([1, 1, 1, 2].my_none?(3)).to be true
      end

      it 'should return false if all elements match parameter ' do
        expect([1, 2, 3, 4].my_none?(Integer)).to be false
      end

      it 'should return true if none elements are truthy' do
        expect([false,nil].my_none?).to be true
      end

      it 'should return true if empty' do
        expect([].my_none?).to be true
      end
    end
  end
end