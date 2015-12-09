#require 'blankslate' unless defined? BasicObject

# This module contains an It class which queues any methods called on it
# and can be converted into a Proc. The Proc it generates executes the queued
# methods in the order received on the argument passed to the block, allowing
# something like the following:
#
#   (1..10).select &it % 2 == 0
# 
module ItsIt

  # The class instantiated by the <code>it</code> and <code>its</code> kernel methods.
  class It < (defined?(BasicObject) ? BasicObject : Object)

    instance_methods.map(&:to_s).each do |method|
      undef_method method unless method.start_with? "__"
    end
  
    def initialize #:nodoc:
      @queue = []
    end
    
    def method_missing(method, *args, &block)
      @queue << [method, args, block] unless method == :respond_to? and [:to_proc, :===].include?(args.first.to_sym)
      self
    end

    def to_proc
      Kernel.send :proc do |*obj|
        obj = obj.shift if obj.size == 1
        @queue.inject(obj) { |chain,(method, args,block)| chain.send(method, *args, &block) }
      end
    end

    def ===(obj)
      self.to_proc.call(obj)
    end

  end
  
end
