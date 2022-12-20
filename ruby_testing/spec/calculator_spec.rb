#spec/calculator_spec.rb
require '../lib/calculator' #=> add this

describe Calculator do
  describe "#add" do
    it "returns the sum of three numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe "#multiply" do
    it "returns the multipy of three numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5, 7)).to eql(70)
    end
  end
  describe "#substract" do
    it "returns the substraction of three numbers" do
      calculator = Calculator.new
      expect(calculator.substract(2, 5, 7)).to eql(-10)
    end
  end
  describe "#divide" do
    it "returns the division of three numbers" do
      calculator = Calculator.new
      expect(calculator.divide(2, 5, 7)).to eql(0.057)
    end
  end
end