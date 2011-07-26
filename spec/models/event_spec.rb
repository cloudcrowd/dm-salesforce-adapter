require File.dirname(__FILE__) + '/../spec_helper'

describe "Creating an Event" do

  describe "when a unique property" do

    before(:each) do
      Event.all(:subject.like => 'Summer picnic%').destroy
    end

    it "is invalid" do
      event = Event.gen(:subject => 'Summer picnic')
      event.should be_valid

      duplicate_subject = Event.gen(:subject => 'Summer picnic')
      duplicate_subject.should_not be_valid
    end

  end

end


describe "Updating an Event" do

  describe "when updating a boolean field to false" do

    before(:each) do
      Event.all(:subject => 'Boolean Update Test').destroy
    end

    it "should update to false" do
      event = Event.gen(:subject => 'Boolean Update Test', :all_day_event => true)
      event.update(:all_day_event => false, :activity_date_time => Time.now)
      Event.get(event.id).all_day_event.should be_false
    end

  end


  describe "when updating a boolean field to true" do
    before(:each) do
      Event.all(:subject => 'Boolean Update Test').destroy
    end
    it "should update to true" do
      event = Event.gen(:subject => 'Boolean Update Test', :all_day_event => false)
      Event.update(:all_day_event => true)
      Event.get(event.id).all_day_event.should be_true
    end
  end


  describe "when a unique property" do

    before(:each) do
      Event.all(:subject.like => 'Summer picnic%').destroy
    end

    it "is invalid" do
      #pending "test duplicates on update elsewhere"
      event = Event.gen(:subject => 'Summer picnic - bring umbrellas')
      event.should be_valid

      conflicting_event_after_update = Event.gen(:subject => 'Summer picnic - bring sunglasses')
      conflicting_event_after_update.should be_valid

      lambda do
        event.update(:subject => 'Summer picnic - bring food')
      end.should_not change { event.valid? }
      lambda do
        conflicting_event_after_update.update(:subject => 'Summer picnic - bring food')
      end.should change { conflicting_event_after_update.valid? }
    end

  end


  describe "filtering on string and boolean" do
    before(:each) do
      Event.all(:subject.like => 'Sack Race').destroy
    end


    it 'includes' do
      account = Account.first
      event = Event.gen(:subject => 'Sack Race', :all_day_event => true)
      Event.all(:subject => 'Sack Race', :all_day_event => true).should include(event)
    end

    it 'excludes' do
      account = Account.first
      event = Event.gen(:subject => 'Sack Race', :all_day_event => true)
      Event.all(:subject => 'Sack Race', :all_day_event => false).should_not include(event)
    end

  end

end
