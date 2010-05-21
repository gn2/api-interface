require File.dirname(__FILE__) + '/helper'

class TestApiInterface < Test::Unit::TestCase

  context "A registered method" do
    setup do
      module Hello::World::Api
        register :method, Hello::World::B, :add
      end
    end

    should "be available in the API" do
      assert Hello::World::Api.respond_to?(:add)
    end

    should "return the same results as the original method" do
      api_method = Hello::World::Api::add(2,3)
      original_method = Hello::World::B::add(2,3)
      assert_equal api_method, original_method
    end
  end # context method

  context "A registered module" do
    setup do
      module Hello::World::Api
        register :module, Hello::World::C, :Module4Api
      end
    end

    should "be available in the API" do
      assert defined?(Hello::World::Api::Module4Api)
    end

    should "expose its public methods" do
      assert Hello::World::Api::Module4Api.instance_methods.include?('bar')
    end

    should "expose its protected methods" do
      assert Hello::World::Api::Module4Api.instance_methods.include?('protected_bar')
    end

    should "hide its private methods" do
      object = Object.new
      object.extend(Hello::World::Api::Module4Api)
      assert_nothing_raised do
        object.send(:private_bar)
      end
    end
  end # context module

  context "A registered class" do
    setup do
      module Hello::World::Api
        register :class, Hello::World::Klass, :Class4Api
      end
    end

    should "be available in the API" do
      assert defined?(Hello::World::Api::Class4Api)
    end

    should "inherits the public methods" do
      assert Hello::World::Api::Class4Api.new.respond_to?(:foo)
    end

    should "inherits the protected methods" do
      assert Hello::World::Api::Class4Api.new.respond_to?(:protected_foo)
    end

    should "inherits the private methods" do
      assert_nothing_raised do
        Hello::World::Api::Class4Api.new.send(:private_foo)
      end
    end
  end # context class

end