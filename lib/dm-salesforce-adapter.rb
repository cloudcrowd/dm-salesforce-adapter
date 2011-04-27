require 'dm-do-adapter'

module DataObjects
  module Salesforce
  end
end

module DataMapper
  module Adapters
    class SalesforceAdapter < DataObjectsAdapter
    end

    const_added(:SalesforceAdapter)
  end
end

require 'dm-salesforce-adapter/adapter'
