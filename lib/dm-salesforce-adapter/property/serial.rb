require 'dm-salesforce-adapter/property'

module DataMapper
  module Adapters
    class SalesforceAdapter < DataObjectsAdapter
      module Property
        class Serial < ::DataMapper::Property::String
          accept_options :serial
          serial true

          length 15

          def typecast(value)
            value.to_str[0..14] unless value.nil? || value.empty?
          end
        end
      end
    end
  end
end
