module God
  
  module Configurable
    # Override this method in your Configurable (optional)
    #
    # Called once after the Configurable has been sent to the block and attributes have been
    # set. Do any post-processing on attributes here
    def prepare
      
    end
    
    # Override this method in your Configurable (optional)
    #
    # Called once during evaluation of the config file. Return true if valid, false otherwise
    #
    # A convenience method 'complain' is available that will print out a message and return false,
    # making it easy to report multiple validation errors:
    #
    #   def valid?
    #     valid = true
    #     valid &= complain("You must specify the 'pid_file' attribute for :memory_usage") if self.pid_file.nil?
    #     valid &= complain("You must specify the 'above' attribute for :memory_usage") if self.above.nil?
    #     valid
    #   end
    def valid?
      true
    end
    
    def friendly_name
      self.class.name.split('::').last
    end
    
    def self.complain(text, c = nil)
      msg = text
      msg += " for #{c.friendly_name}" if c
      Syslog.err(msg)
      puts msg
      false
    end
    
    def complain(text, c = nil)
      Configurable.complain(text, c)
    end
  end
  
end