# Provides .ero and #ero to classes and modules to which this module is included.
module Ero
  def ero(msg: nil, err: nil)
    class_name = self.is_a?(Module) ? self.name : self.class.name
    separator = self.is_a?(Module) ? '.' : '#'
    # Extract the originating method's name from near the end of the first
    # line of the current stack trace, then trim extraneous verbage:
    method_name = caller[0][/`.*'/][1..-2].gsub(/.+ in /, '')

    failure_to_log =
      case [!msg.nil?, !err.nil?]
      when [true, true] then "#{msg} - #{class_name}#{separator}#{method_name} failed - #{err}"
      when [true, false] then "#{msg} - #{class_name}#{separator}#{method_name} failed"
      when [false, true] then "#{class_name}#{separator}#{method_name} failed - #{err}"
      when [false, false] then "#{class_name}#{separator}#{method_name} failed"
      end

    Rails.logger.error(failure_to_log)
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def ero(msg: nil, err: nil)
      class_name = self.is_a?(Module) ? name : self.class.name
      separator = self.is_a?(Module) ? '.' : '#'
      # Extract the originating method's name from near the end of the first
      # line of the current stack trace, then trim extraneous verbage:
      method_name = caller[0][/`.*'/][1..-2].gsub(/.+ in /, '')

      failure_to_log =
        case [!msg.nil?, !err.nil?]
        when [true, true] then "#{msg} - #{class_name}#{separator}#{method_name} failed - #{err}"
        when [true, false] then "#{msg} - #{class_name}#{separator}#{method_name} failed"
        when [false, true] then "#{class_name}#{separator}#{method_name} failed - #{err}"
        when [false, false] then "#{class_name}#{separator}#{method_name} failed"
        end

      Rails.logger.error(failure_to_log)
    end
  end
end
