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
    context 'when parameter is given' do
      it 'should return true if all elements match Class parameter' do
        expect([1, 2, 3, 4].my_all?(Integer)).to be true
      end

      it 'should return true if all elements match Regex' do
        expect(%w[a b c d].my_all?(/[abcd]/)).to be true
      end

      it 'should return true if all elements match other any paramter' do
        expect([1, 1, 1, 1].my_all?(1)).to be true
      end
    end
    context 'when no parameter is given' do
      it 'should return false if any elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_all?(Integer)).to be false
      end

      it 'should return true if all elements are truthy' do
        expect([1, 'a', 1.4].my_all?).to be true
      end

      it 'should return false if any elements is falsy' do
        expect([1, 'a', nil].my_all?).to be false
      end

      it 'should return true if empty' do
        expect([].my_all?).to be true
      end
    end
  end

  describe '#my_any?' do
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
        expect([1, 2, 3, 's'].my_any?(String)).to be true
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
    end
    context 'when no parameters are given' do
      it 'should return true if any elements are truthy' do
        expect([1, nil, 1.4].my_any?).to be true
      end

      it 'should false if all elements are false' do
        expect([false, nil].my_any?).to be false
      end

      it 'should return false if empty' do
        expect([].my_any?).to be false
      end
    end
  end

  describe '#my_none?' do
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
        expect([1, 2, 3, 's'].my_none?(Float)).to be true
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

      it 'should return true if empty' do
        expect([].my_none?).to be true
      end
    end
    context 'when no parameter is given' do
      it 'should return true if none elements are truthy' do
        expect([false, nil].my_none?).to be true
      end
      it 'should return false if any elements is truthy' do
        expect([false, nil, true].my_none?).to be false
      end
    end
  end

  describe '#my_count' do
    context 'when block is given' do
      it 'should return the count of the elements in block returning true' do
        expect([1, 2, 3, 4].my_count { |ele| ele.is_a?(Integer) }).to eq(4)
      end

      it 'should return count zero if no elements pass the block returning true' do
        expect([1, 2, 3, 4].my_count { |ele| ele.is_a?(String) }).to eq(0)
      end
    end
    context 'when paramter is given' do
      it 'should return count of elements matching Class parameter' do
        expect([1, 2, 3, 's'].my_count(String)).to eq(1)
      end

      it 'should return count of elements matching Regex' do
        expect(%w[a b c g].my_count(/[abcd]/)).to eq(3)
      end

      it 'should return count of elements matching any other paramter' do
        expect([1, 1, 1, 2].my_count(1)).to eq(3)
      end

      it 'should return 0 all elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_count(Float)).to eq(0)
      end

      it 'should return 0 for empty enumerables' do
        expect([].my_count).to eq(0)
      end
    end
    context 'when paramter is not given' do
      it 'should return length of the array' do
        expect([1, nil, 1.4].my_count).to eq(3)
      end
      it 'should return 0 for empty enumerables' do
        expect([].my_count).to eq(0)
      end
    end
  end

  describe "#my_map" do
    it "should return Enumerator when no proc or block is given" do
      expect([1,2,3].my_map).to be_a(Enumerable)
    end
    context "When proc is given" do
      it "should return an array mapping every element through calling the proc" do
        before = [1,2,3,4,5]
        after = [10,20,30,40,50]
        proc = Proc.new {|ele| ele*10}
        expect(before.my_map(proc)).to eq(after)
      end
    end
    context "When block is given" do
      it "should return an array mapping every element returning from the block" do
        before = [1,2,3,4,5]
        after = [10,20,30,40,50]
        expect(before.my_map {|ele| ele*10}).to eq(after)
      end

    end
  end
end
