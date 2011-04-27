class SalesforceAdapter < ::DataMapper::Adapters::AbstractAdapter
  module Resource
    def self.included(model)
      model.send :include, DataMapper::Resource
      model.send :include, SalesforceAdapter::Property
    end
  end
end
