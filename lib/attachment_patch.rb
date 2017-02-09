require 'net/http'
  # Patches Redmine's Issues dynamically.  
  module AttachmentPatch
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
        data_to_send = ["issueid" => self.id, "userid" => self.author_id, "datetime" => self.created_on]
        Net::HTTP.get(Setting.plugin_redmine_transaction_informer['domain'],  Setting.plugin_redmine_transaction_informer['url'] + '?id=' + data_to_send.to_json)
        return true
      end

    end    
  end
