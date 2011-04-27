class SalesforceAdapter < ::DataMapper::Adapters::AbstractAdapter
  module Property
  end
end

require 'dm-salesforce-adapter/property/serial'
require 'dm-salesforce-adapter/property/boolean'
