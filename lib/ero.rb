# Include this module in a Rails class or module to gain access to function #ero
module Ero
  def ero(message: nil, error: nil)
    class_name = self.is_a?(Module) ? self.name : self.class.name
    separator = self.is_a?(Module) ? '.' : '#'
    # Extract the originating method's name from near the end of the first line of the current stack trace
    method_name = caller[0][/`.*'/][1..-2].gsub(/.+ in /, '')

    failure_to_log =
      case [!message.nil?, !error.nil?]
      when [true, true] then "#{message} - #{class_name}#{separator}#{method_name} failed - #{error}"
      when [true, false] then "#{message} - #{class_name}#{separator}#{method_name} failed"
      when [false, true] then "#{class_name}#{separator}#{method_name} failed - #{error}"
      when [false, false] then "#{class_name}#{separator}#{method_name} failed"
      end

    Rails.logger.error(failure_to_log)
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def ero(message: nil, error: nil)
      class_name = self.is_a?(Module) ? name : self.class.name
      separator = self.is_a?(Module) ? '.' : '#'
      # Extract the originating method's name from near the end of the first
      # line of the current stack trace, then trim extraneous verbage:
      method_name = caller[0][/`.*'/][1..-2].gsub(/.+ in /, '')

      failure_to_log =
        case [!message.nil?, !error.nil?]
        when [true, true] then "#{message} - #{class_name}#{separator}#{method_name} failed - #{error}"
        when [true, false] then "#{message} - #{class_name}#{separator}#{method_name} failed"
        when [false, true] then "#{class_name}#{separator}#{method_name} failed - #{error}"
        when [false, false] then "#{class_name}#{separator}#{method_name} failed"
        end

      Rails.logger.error(failure_to_log)
    end
  end
end
