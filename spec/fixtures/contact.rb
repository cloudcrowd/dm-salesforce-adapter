class Contact
  include DataMapper::Salesforce::Resource

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

  belongs_to :account
end

Contact.fix {{
  :first_name => /\w+/.gen,
  :last_name  => /\w+/.gen,
  :email      => /\w+@example.com/.gen,
  :account    => Account.gen,
}}
