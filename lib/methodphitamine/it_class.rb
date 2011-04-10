require 'blankslate'

# This module contains an It class which queues any methods called on it
# and can be converted into a Proc. The Proc it generates executes the queued
# methods in the order received on the argument passed to the block, allowing
# something like the following:
#
#   (1..10).select &it % 2 == 0
# 
# For more examples, see http://methodphitamine.rubyforge.org.
module Methodphitamine
  
  # The class instantiated by the it() and its() methods from monkey_patches.rb.
  class It < BlankSlate
  
    def initialize
      @methods = []
    end
    
    def method_missing(*args, &block)
      @methods << [args, block] unless args == [:respond_to?, :to_proc]
      self
    end
  
    def to_proc
      lambda do |obj|
        @methods.inject(obj) do |current,(args,block)|
          current.send(*args, &block)
        end
      end
    end

    # Used for testing this class.
    def methodphitamine_queue
      @methods
    end
    
  end
  
  class MethodphitamineMaybe < It
    def to_proc
      Proc.new do |obj|
        @methods.inject(obj) do |current,(args,block)|
          new_current = current.send(*args, &block)
          return current unless new_current
          new_current
        end
      end
    end
  end
  
end
