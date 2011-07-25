class Account
  include DataMapper::Salesforce::Resource

  def self.default_repository_name
    :salesforce
  end

  def self.salesforce_id_properties
    :id
  end

  property :id,                   Serial
  property :name,                 String,  :required => true
  property :annual_revenue,       Float
  property :number_of_employees,  Integer
  property :deleted,              Boolean, :field => "IsDeleted"

  has n, :contacts
end

Account.fix {{
  :name                 => Randgen.first_name,
  :annual_revenue       => rand(1_000).to_f / 100,
  :number_of_employees  => (1..10).pick,
}}
