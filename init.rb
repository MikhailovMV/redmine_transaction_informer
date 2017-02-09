require_dependency 'issue'
require_dependency 'attachment'

# Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? IssuePatch
    Issue.send(:include, IssuePatch)
  end
  unless Attachment.included_modules.include? AttachmentPatch
    Attachment.send(:include, AttachmentPatch)
  end

Redmine::Plugin.register :redmine_transaction_informer do
  name 'Redmine Transaction Informer plugin'
  author 'Mikhailov Mikhail'
  description 'This is a plugin for Redmine, which sends to foreign URL JSON about transaction data'
  version '0.0.1'
  url 'https://github.com/MikhailovMV/redmine_transaction_informer'
  author_url 'http://profit-lab.top'
  settings :default => { 'domain' => 'profit-lab.top', 'url' => '/htmls/counter.php'}, :partial => 'settings/plugin'
end
