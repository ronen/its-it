require File.dirname(__FILE__) + "/spec_helper"

describe Object do
  it "doesn't get ItsIt's version" do
    expect(defined?(::VERSION)).to be_nil
  end

  it "does't get the It class" do
    expect(defined?(::It)).to be_nil
  end
end
