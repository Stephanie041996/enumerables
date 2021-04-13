
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




describe 'my_each_with_index' do
     describe 'when block is given' do
          it 'should execute the code for each element with its index' do
     arr =[]
               %w[Sharon Leo Leila Brian Arun].my_each_with_index { |ele, index| arr << ele if index.even? }
               expect(arr).to eq(%w[Sharon Leila  Arun])

     end
     end

     describe 'when no block given' do
          it ' should return enumerator'do
          arr = [1,2,3]
          expect(arr.my_each_with_index).to be_a(Enumerator)

     end
     end


end
describe "my select" do
          describe "block is given" do
               it "executes code for selected elements inside the array" do
               arr = [1,2,3,4,5]
               em_arr = []
             
               arr.my_select{|el|em_arr << el if el.odd? }
               expect(em_arr).to eq([1,3,5])
          end
          end

          describe "block is not given" do
               it"returns Enumerator if block is not given" do
                    arr = [1,2,3,4,5]
               expect(arr.my_select).to be_a(Enumerator)
               end
          end
end