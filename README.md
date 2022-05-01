# Ero - Expressive Rails Oopsies
Lightweight gem providing access to the utility module `Ero`.

By including Ero in your Rails classes or modules, you can use #ero to write error-level log entries for method failures.

# One
one

## Two
two

### Three
three

#### Four
four

##### Five
five

###### Six
six
```
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
ExampleKlass.instafail
ExampleModule.divide_by_zero
```
...will write the following line to the error level of your application's Rails log:
"Couldn't do the thing you were trying to do. - ExampleKlass#foo failed - undefined method `+' for nil:NilClass"
