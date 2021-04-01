require "enumerables"

describe "Enumerable" do
  describe "#my_each" do
    context "when no block is given" do
      it "should return Enumerable" do
        array = [1,2,3,4,5]
        expect(array.my_each).to be_a(Enumerable)
      end
    end
  end
end
