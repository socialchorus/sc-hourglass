require 'spec_helper'

describe Events::Serializer do
   let(:a_moment) { Time.now }
   let(:event) {
     Event.create({
      name: 'evento',
      status: 'running',
      start_time: a_moment,
      end_time: a_moment
     })
   }
   let(:serializer) { Events::Serializer.new }
   let(:serialized_event) { serializer.serialize(event) }

  describe '#serialize' do
    context "the event should get serialized" do
       it "serializes the event" do
         serialized_event[:name].should == 'evento'
         serialized_event[:status].should == 'running'
         serialized_event[:start_time].should == a_moment.localtime
       end
    end

    context "event has no end time" do
       it "sets the end time to nil" do
         event.update_attribute(:end_time, nil)
         serialized_event[:end_time].should == nil
       end
    end

    context "event has end time" do
      it "sets the right end time" do
        serialized_event[:end_time].should == a_moment.localtime
      end
    end
  end
end
