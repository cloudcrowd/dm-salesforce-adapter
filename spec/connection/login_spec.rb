require File.dirname(__FILE__) + '/../spec_helper'

module DataMapper::Salesforce
  describe "Using the raw connection" do
    describe "when authenticating without an organization id" do

      describe "with the correct credentials" do

        it "succeeds" do
          db = ::DataMapper.repository(:salesforce).adapter.connection
          SalesforceAdapter::Connection.new(VALID_USERNAME, VALID_PASSWORD, db.wsdl_path, db.api_dir)
        end

      end


      describe "with an invalid password" do

        it "fails to login" do
          db = ::DataMapper.repository(:salesforce).adapter.connection
          lambda {
            SalesforceAdapter::Connection.new(VALID_USERNAME, 'bad-password', db.wsdl_path, db.api_dir)
          }.should raise_error(SalesforceAdapter::Connection::Errors::LoginFailed)
        end

      end

    end
  end
end
