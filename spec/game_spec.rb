
require_relative '../enumerables'

describe '#my_each' do
     describe "block is given" do
     it 'execute code for each element inside the array' do
     arr = []
     ["Sharon", "Leo", "Leila", "Brian", "Arun"].my_each{|el| arr<<el}
     expect(arr).to eq(["Sharon", "Leo", "Leila", "Brian", "Arun"])
end
end
     describe "block is not given" do
          it"returns enumerable" do
          arr = [1,2,3]
          expect(arr.my_each).to be_a(Enumerator)
     end
end
end