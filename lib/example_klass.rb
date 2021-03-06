require './lib/ero'

class ExampleKlass
  include ::Ero

  def find_a_thing(id)
    example_record = ExampleModel.find(id)
    return ero(msg: 'Record not found') unless example_record.present

    example_record
  end

  def self.instafail
    raise StandardError
  rescue StandardError => e
    ero(err: e)
  end
end

module ExampleModule
  include ::Ero

  def self.divide_by_zero
    1 / 0
  rescue ZeroDivisionError => e
    ero(msg: 'Hm, I thought this would work...', err: e)
  end
end

ExampleKlass.new.find_a_thing(1)
ExampleKlass.instafail
ExampleModule.divide_by_zero
