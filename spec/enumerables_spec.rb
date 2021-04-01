require "enumerables"

describe "Enumerable" do
  describe "#my_each" do
    context "when no block is given" do
      it "should return Enumerable" do
        array = [1,2,3,4,5]
        expect(array.my_each).to be_a(Enumerable)
      end
    end
    context "when block is given" do
      it "should execute the block for each element" do
        before = []
        after = [1,2,3,4,5]
        after.my_each {|ele| before << ele}
        expect(before).to eq(after)
      end

      it "should return self with same object id" do
        array = [1,2,3]
        expect(array.my_each {|ele| ele}).to be(array)
      end
    end
  end
end
