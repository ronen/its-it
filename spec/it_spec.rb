require File.dirname(__FILE__) + "/spec_helper"

describe "An It instance" do

  before (:each) do
    it = ItsIt::It.new
    @string = "This is a test"
  end

  it "should start with identity via to_proc" do
    it.to_proc.call(@string).should == @string
  end

  it "should start with identity via ===" do
    (it === @string).should == @string
  end

  it "should work with a simple method via to_proc" do
    (it.length).to_proc.call(@string).should == @string.length
  end

  it "should work with a simple methoud using ===" do
    ((it.length) === @string).should == @string.length
  end
  
  it "should work with arguments" do
    (it.sub(/test/, 'kumquat')).call(@string).should == 'This is a kumquat'
  end
  
  it "should work with a block" do
    (it.sub(/test/) {"balloon"}).to_proc.call(@string).should == 'This is a balloon'
  end
  
  it "should chain methods" do
    it.reverse.swapcase.succ.should == "TSET A SI SIHu"
  end
  
  it "should respond to to_proc()" do
    it.should respond_to(:to_proc)
  end

  it "should respond to ===" do
    it.should respond_to(:===)
  end

  it "should work with numbers" do
    ((it < 1) === 0).should be_true
    ((it < 1) === 1).should be_false
    ((it < 1) === 2).should be_false
  end

  it "should work in a case statement" do
    [0,1,2].each do |i|
      case i
      when it < 1 then i.should == 0
      when it == 1 then i.should == 1
      else i.should == 2
      end
    end
  end
  
  it "should not queue the method respond_to? when given :to_proc as an arg" do
    (it.respond_to? :to_proc).should be_true
  end

  it "should not queue the method respond_to? when given :=== as an arg" do
    (it.respond_to? :===).should be_true
  end

  it "should queue the method respond_to? when given generic arg" do
    (it.respond_to? :size).to_proc.call(@string).should be_true
  end
  
end
