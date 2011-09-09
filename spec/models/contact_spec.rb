require File.dirname(__FILE__) + '/../spec_helper'

describe "Finding a Contact" do
  let(:valid_id) { DataMapper.repository(:salesforce) { Contact.gen.id } }

  it "return the first element" do
    Contact.first(:id => valid_id).should_not be_nil
  end

  it "has a 18 character long id" do
    #pending "testing serial types should be done elsewhere"
    Contact.first(:id => valid_id).id.size.should == 18
  end

  it "has a 18 character long account_id" do
    #pending "testing association ids as serial types should be done elsewhere"
    Contact.first(:id => valid_id).account_id.size.should == 18
  end

  it "should get a single contact" do
    Contact.get(valid_id).should_not be_nil
    Contact.get(valid_id).should be_valid
  end

  it "handles not operator" do
    Contact.first(:id.not => valid_id).should_not == Contact.get(valid_id)
  end
end

describe "Creating a Contact" do

  describe "specifying an account to associate with" do
    let(:account) { Account.gen }
    describe "using the object" do
      it 'is valid' do
        contact = Contact.create(:first_name => 'Per', :last_name => 'Son', :email => "person@company.com", :account => account)
        contact.should be_valid
        contact.account.should eql(account)
      end
    end
    describe "using the id" do
      it 'is valid' do
        contact = Contact.create(:first_name => 'Per', :last_name => 'Son', :email => "person@company.com", :account_id => account.id)
        contact.should be_valid
        contact.account.should eql(account)
      end
    end
  end

  describe "when the email address is invalid" do
    it "is invalid" do
      contact = Contact.gen(:email => "person")
      contact.should_not be_valid
      contact.errors.should have_key(:email)
    end
  end

  describe "when the last name is missing" do
    it "is invalid" do
      contact = Contact.create(:first_name => 'Per', :email => "person@company.com")
      contact.should_not be_valid
      contact.errors.should have_key(:last_name)
    end
  end
end

describe "Allocating a Contact" do
  describe "when the last name is missing" do
    it "has validation errors" do
      c = Contact.make(:last_name => nil)
      c.should_not be_valid
      c.errors.should have_key(:last_name)
    end
  end
end

describe "Updating a Contact" do
  describe "when the email address is invalid" do
    it "is invalid" do
      c = Contact.create(:first_name => 'Per', :last_name => 'Son', :email => "person@company.com")
      c.update(:email => 'person')
      c.should_not be_valid
      c.errors.should have_key(:email)
    end
  end

  describe "when the last name is missing" do
    it "is invalid" do
      contact = Contact.create(:first_name => 'Per', :last_name => 'Son', :email => "person@company.com")
      contact.update(:last_name => "")
      contact.should_not be_valid
      contact.errors.should have_key(:last_name)
    end
  end

end
