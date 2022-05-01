# Ero - Expressive Rails Oopsies
Lightweight gem providing access to the utility module `Ero`.

By including Ero in your Rails classes or modules, you can use #ero to write error-level log entries for method failures.

## Usage
Ero provides an instance method `#ero` and class method `.ero`. These methods behave identically.

Both, either, or neither of the two optional named parameters, `msg` and `err`, may be provided.

Without arguments, only a base message will be logged: "Class.method failed" or "Class#method failed".

If provided, `msg` will be prepended and `err` will be appended to the base. Refer to the example implementation on how the logged message changes with different arguments.

```ruby
class ExampleKlass
  include ::Ero

  def find_a_thing(id)
    example_record = ExampleModel.find(id)
    return ero(message: 'Record not found') unless example_record.present

    example_record
  end

  def self.instafail
    raise StandardError
  rescue StandardError => e
    ero(error: e)
  end
end

module ExampleModule
  include ::Ero

  def self.divide_by_zero
    1 / 0
  rescue ZeroDivisionError => e
    ero(message: 'Hm, I thought this would work...', error: e)
  end
end

ExampleKlass.new.find_a_thing(1)
=> "Record not found - ExampleKlass#find_a_thing failed"

ExampleKlass.instafail
=> "ExampleKlass.instafail failed - StandardError"

ExampleModule.divide_by_zero
=> "Hm, I thought this would work... - ExampleModule.divide_by_zero failed - divided by 0"
```
