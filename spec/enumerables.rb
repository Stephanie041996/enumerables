
require_relative '../enumerables'

describe '#my_each' do
it 'execute code for each element inside the array' do
expect([1,2,3,4,5].my_each).to eq(1,2,3,4,5)
end
end