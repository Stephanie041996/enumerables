require_relative '../enumerables'

describe '#my_each' do
  describe 'when block is given' do
    it 'executes code for each element inside the array' do
      arr = []
      %w[Sharon Leo Leila Brian Arun].my_each { |el| arr << el }
      expect(arr).to eq(%w[Sharon Leo Leila Brian Arun])
    end
  end

  describe 'when block is not given' do
    it 'returns enumerable' do
      arr = [1, 2, 3]
      expect(arr.my_each).to be_a(Enumerator)
    end
  end
end

describe 'my_each_with_index' do
  describe 'when block is given' do
    it 'should execute the code for each element with its index' do
      arr = []
      %w[Sharon Leo Leila Brian Arun].my_each_with_index { |ele, index| arr << ele if index.even? }
      expect(arr).to eq(%w[Sharon Leila Arun])
    end
  end

  describe 'when no block given' do
    it ' should return enumerator' do
      arr = [1, 2, 3]
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end
  end
end

describe 'my select' do
  describe 'block is given' do
    it ' returns an array  passing each element inside the block' do
      arr = [1, 2, 3, 4, 5]
      empty_arr = []

      arr.my_select { |el| empty_arr << el if el.odd? }
      expect(empty_arr).to eq([1, 3, 5])
    end
  end
  describe 'block is not given' do
    it 'returns Enumerator if block is not given' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_select).to be_a(Enumerator)
    end
    it 'should return an empty array if block condition is not true' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_select { false }).to be_empty
    end
  end
end

describe 'my_all' do
  describe 'when block is given' do
    it 'should return true if all elements meet the condition' do
      arr = [1, 1, 1]
      result = arr.my_all? { |ele| ele == 1 }
      expect(result).to eq(true)
    end
    it 'should return false if all elements do not meet the condition' do
      arr = [1, 1, 2]
      result = arr.my_all? { |ele| ele == 1 }
      expect(result).to eq(false)
    end
  end
  describe 'when parameter is  given' do
    it 'should return true' do
      arr = [1, 1, 1]
      expect(arr.my_all?(Integer)).to be true
    end

    it 'should return false' do
      arr = [1, 1, 1, 'hie']
      expect(arr.my_all?(Integer)).to be false
    end
    it 'should return true if empty' do
      expect([].my_all?).to be true
    end
  end

  describe 'when parameter is not given' do
    it 'should return true' do
      arr = [1, 1, 1]
      expect(arr.my_all?).to be true
    end
    it 'should return false' do
      arr = [1, 1, 1, false]
      expect(arr.my_all?).to be false
    end
  end
end

describe 'my_any?' do
  describe ' when block is given' do
    it 'should return true if any parameter meets the conditon' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_any? { |ele| ele > 2 }).to eq(true)
    end

    it 'should return false if any parameter meets the conditon' do
      arr = [1, 2, 3, 4]
      expect(arr.my_any? { |ele| ele > 6 }).to eq(false)
    end
  end
  describe ' when parameter is given' do
    it 'should return true any of elements meet the condition' do
      arr = [2, 3, 5, 6]
      expect(arr.my_any?(Integer)).to eq true
    end

    it 'should return false any of elements do not meet the condition' do
      arr = [2, 3, 5, 6]
      expect(arr.my_any?(String)).to eq false
    end
  end

  describe 'when parameter is not given' do
    it 'should return true if any elements are truthy' do
      expect([1, 2, 3, 'hie'].my_any?).to eq true
    end
    it 'should return false if all elements are falsy' do
      expect([nil, false].my_any?).to eq false
    end
  end
end

describe 'my_none?' do
  describe 'when block is given' do
    it 'returns true if none of the elements meet the condition' do
      expect([1, 1, 1].my_none? { |el| el > 2 }).to eq(true)
    end
    it 'returns false if any of the elements meet the condition' do
      expect([1, 1, 3].my_none? { |el| el > 2 }).to eq(false)
    end
  end
  describe 'when param is given' do
    it 'returns true if none of the elements meet the condition' do
      expect([true, 'hey'].my_none?(Integer)).to eq(true)
    end
    it 'returns false if any of the elements meet the condition' do
      expect([1, 2].my_none?(Integer)).to eq(false)
    end
  end
  describe 'should return false if any elements are truthy' do
    it 'should return false ' do
      expect([1, true, false].my_none?).to eq false
    end
    it 'should return true if none elements are truthy' do
      expect([nil, false].my_none?).to eq true
    end
  end
end

describe 'my_count' do
  describe 'when block is given' do
    it 'should return the count of the elements in block matching condition' do
      expect([1, 2, 3].my_count { |el| el > 2 }).to eq(1)
    end
    it 'should return the count 0 if no elements in block match the condition' do
      expect([1, 2, 3].my_count { |el| el > 3 }).to eq(0)
    end
  end
  describe 'when parameter is given' do
    it 'should return the count of the elements in block matching param condition' do
      expect([1, 2, 3, 'el'].my_count(Integer)).to eq(3)
    end
    it 'should return the count 0 if no elements in block match the param condition' do
      expect([false, nil].my_count(Integer)).to eq(0)
    end
  end
  describe 'when param is not given' do
    it 'returns arr length if param is not given ' do
      expect([1, 2, 3].my_count).to eq(3)
    end
    it 'returns 0 for empty enumerables' do
      expect([].my_count).to eq(0)
    end
  end
end

describe 'my_map' do
  describe 'block is given' do
    it 'should return an array mapping all the elements in the orginal array' do
      expect([1, 2, 3].my_map { |ele| ele * 2 }).to eq [2, 4, 6]
    end
  end
  describe 'block not given' do
    it ' should return enumerator' do
      expect([1, 2, 3].my_map).to be_a(Enumerator)
    end
  end
end

describe 'my_inject' do
  it 'calls LocalJumpError' do
    expect { [1, 2, 3].my_inject }.to raise_error LocalJumpError
  end

  describe 'when block is given' do
    describe 'when param is given' do
      it 'returns sum of all arr elemets starting from param' do
        expect([1, 2, 3].my_inject(5) { |sum, el| sum + el }).to eq(11)
      end
      describe 'when param is not given' do
        it 'returns sum of all arr elemets' do
          expect([1, 2, 3].my_inject { |sum, el| sum + el }).to eq(6)
        end
      end
    end
  end
  describe 'when block is not given, starting point & symbol is given' do
    it 'should return sum of arr elements starting from param' do
      expect([1, 2, 3].my_inject(4, :+)).to eq(10)
    end
  end
  describe 'when block is not given,only symbol is given' do
    it 'should return sum of arr elements ' do
      expect([1, 2, 3].my_inject(:+)).to eq(6)
    end
  end
end
