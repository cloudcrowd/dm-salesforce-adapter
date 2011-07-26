require File.dirname(__FILE__) + '/../spec_helper'

describe SalesforceAdapter::Property::Boolean do
  let(:all_day_event) { DataMapper.repository(:salesforce) { Event.gen(:all_day_event => true) } }
  let(:quick_event) { DataMapper.repository(:salesforce) { Event.gen(:all_day_event => false) } }


  describe 'dumps and loads' do

    it 'should be true' do
      Event.first(:id => all_day_event.id).all_day_event.should be_true
    end

    it 'should be false' do
      Event.first(:id => quick_event.id).all_day_event.should be_false
    end

  end


  describe 'after create' do

    it 'should be true' do
      all_day_event.all_day_event.should be_true
    end

    it 'should be false' do
      quick_event.all_day_event.should be_false
    end

  end


  describe 'full cycle' do

    it 'should be true all the way through' do
      event = Event.gen(:all_day_event => true)
      event.all_day_event.should be_true
      event.save.should be_true
      event.all_day_event.should be_true
      event.reload.all_day_event.should be_true
      Event.first(:id => event.id).all_day_event.should be_true
    end


    it 'should be false all the way through' do
      event = Event.gen(:all_day_event => false)
      event.all_day_event.should be_false
      event.save.should be_true
      event.all_day_event.should be_false
      event.reload.all_day_event.should be_false
      Event.first(:id => event.id).all_day_event.should be_false
    end

  end

end
