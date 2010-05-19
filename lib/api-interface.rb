module ApiInterface

  def register(kind, object, name)
    return false unless name

    # Below, we include a module to add methods and classes. We are
    # using the behaviour of Module#append_features. The content
    # of these Module will only be added to the API if it's not already
    # defined
    # Read this for more info: http://ruby-doc.org/core/classes/Module.html#M001636

    case kind
    # When including methods in Api
    # object = The method to add
    # name = Name of the method added to API
    when :method then
      # object
      include Module.new {
        class_eval <<-RUBY
          define_method name do |*args|
            #{object}::#{name}(*args)
          end
        RUBY
      }
      module_function name
      public name

    # When adding a module in Api
    # object = Module to include
    # name = Name of the new module in API
    when :module then
      include Module.new {
        class_eval <<-RUBY
          module #{name.to_s}
             extend #{object}
          end.freeze
        RUBY
      }

    # When adding a module in Api
    # object = Module to include
    # name = Name of the new class in API
    when :class then
      include Module.new {
        class_eval <<-RUBY
          class #{name.to_s} < #{object}
          end.freeze
        RUBY
      }
    end # case
  end # register method
  protected :register

end