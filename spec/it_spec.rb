require File.dirname(__FILE__) + "/spec_helper"

describe ItsIt::It do

  TestString = "This is a test"

  it "should start with identity via to_proc" do
    expect(it.to_proc.call(TestString)).to eq(TestString)
  end

  it "should start with identity via ===" do
    expect(it === TestString).to eq(TestString)
  end

  it "should work with a simple method via to_proc" do
    expect((it.length).to_proc.call(TestString)).to eq(TestString.length)
  end

  it "should work with a simple method using ===" do
    expect((it.length) === TestString).to eq(TestString.length)
  end
  
  it "should work with arguments" do
    expect((it.sub(/test/, 'kumquat')).call(TestString)).to eq('This is a kumquat')
  end
  
  it "should work with a block" do
    expect((it.sub(/test/) {"balloon"}).to_proc.call(TestString)).to eq('This is a balloon')
  end
  
  it "should chain methods" do
    expect((it.reverse.swapcase.succ).to_proc.call(TestString)).to eq("TSET A SI SIHu")
  end
  
  it "should respond to to_proc()" do
    expect(it).to respond_to(:to_proc)
  end

  it "should respond to ===" do
    expect(it).to respond_to(:===)
  end

  it "should work with numbers" do
    expect((it < 1) === 0).to be_truthy
    expect((it < 1) === 1).to be_falsey
    expect((it < 1) === 2).to be_falsey
  end

  it "should work with hashes (multiple args)" do
    expect({a: 1, b:2}.select &it[1] == 2).to eq({b:2})
  end


  it "should work in a case statement" do
    [0,1,2].each do |i|
      case i
      when it < 1 then expect(i).to eq(0)
      when it == 1 then expect(i).to eq(1)
      else expect(i).to eq(2)
      end
    end
  end
  
  it "should not queue the method respond_to? when given :to_proc as an arg" do
    expect(it.respond_to? :to_proc).to be_true
  end

  it "should not queue the method respond_to? when given :=== as an arg" do
    expect(it.respond_to? :===).to be_true
  end

  it "should queue the method respond_to? when given generic arg" do
    expect((it.respond_to? :size).to_proc.call(TestString)).to be_truthy
  end

end
