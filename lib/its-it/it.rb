require 'blankslate'

# This module contains an It class which queues any methods called on it
# and can be converted into a Proc. The Proc it generates executes the queued
# methods in the order received on the argument passed to the block, allowing
# something like the following:
#
#   (1..10).select &it % 2 == 0
# 
module ItsIt
  
  # The class instantiated by the <code>it</code> and <code>its</code> kernel methods.
  class It < BlankSlate
  
    def initialize #:nodoc:
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

    # Used for testing.  This method is hidden but can be revealed using
    #   ItsIt::It.reveal(:method_queue)
    def method_queue
      @methods
    end
    hide(:method_queue)
    
  end
  
end
