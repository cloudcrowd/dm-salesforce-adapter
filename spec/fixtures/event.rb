class Event
  include DataMapper::Salesforce::Resource

  def self.default_repository_name
    :salesforce
  end

  def self.salesforce_id_properties
    [:id, :account_id]
  end

  property :id,                   Serial
  property :subject,              String,   :required => false, :unique => true
  property :all_day_event,        Boolean,  :field => "IsAllDayEvent"
  property :activity_date,        Date,     :required => true
  property :activity_date_time,   Time,     :required => true
  property :duration_in_minutes,  Integer,  :required => true
end


Event.fix {{
  :subject             => /\w+/.gen,
  :all_day_event       => [true, false].pick,
  :activity_date       => Time.local(2011, 1, 1),
  :activity_date_time  => Time.local(2011, 1, 1),
  :duration_in_minutes => 1440,
}}
