require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'api-interface'

class Test::Unit::TestCase
end

module Hello
  module World
    class Klass
      def foo
        puts "Hello Klass#foo"
      end
      protected
      def protected_foo
        puts "Hello Klass#protected_foo"
      end
      private
      def private_foo
        puts "Hello Klass#private_foo"
      end
    end

    module B
      def self.add(a,b)
        return a + b
      end
    end

    module C
      def bar
        puts "Hello bar"
      end

      protected
      def protected_bar
        puts "Hello protected_bar"
      end

      private
      def private_bar
        puts "Hello private_bar"
      end
    end
  end
end

module Hello
  module World
    module Api
      extend ApiInterface
    end
  end
end