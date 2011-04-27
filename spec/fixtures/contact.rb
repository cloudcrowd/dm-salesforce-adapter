class Contact
  include DataMapper::Resource
  include DataMapper::Adapters::SalesforceAdapter::Property

  def self.default_repository_name
    :salesforce
  end

  def self.salesforce_id_properties
    [:id, :account_id]
  end

  property :id,                         Serial
  property :first_name,                 String
  property :last_name,                  String, :required => true
  property :email,                      String, :format   => :email_address
  property :account_id,                 String
  property :irc_nick,                   String, :required => false, :unique => true
  property :active,                     Boolean
  property :has_opted_out_of_email,     Boolean

  belongs_to :account
end

Contact.fixture do
  {
    :first_name => /\w+/.gen,
    :last_name  => /\w+/.gen,
    :email      => /\w+@example.com/.gen,
    :account    => Account.gen,
    :has_opted_out_of_email => [true, false].pick,
  }
end
