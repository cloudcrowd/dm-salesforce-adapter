module SalesforceAdapter::Property
  class Serial < ::DataMapper::Property::String
    accept_options :serial
    serial true

    length 18

    def dump(value)
      value.to_s[0..17]
    end
  end
end
