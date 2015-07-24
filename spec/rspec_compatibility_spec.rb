require File.dirname(__FILE__) + "/spec_helper"

describe "RSpec compatibility" do
  
  # Surprisingly, RSpec's it() method isn't even defined within the context
  # of each expectation block. Man, that's some crazy voodoo.
  
  it "should make available the it and its methods" do
    expect(method(:it)).to eq method(:its) # Ensure it's not RSpec's it() method
    expect {
      it.should be_kind_of(ItsIt::It)
    }.to_not raise_error
  end
  
  it "should work with RSpec's old :should syntax" do
    [1,2,3].each &it.should(be_kind_of(Fixnum))
  end
end
