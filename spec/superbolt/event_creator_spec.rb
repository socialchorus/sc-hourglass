require 'spec_helper'

describe EventCreator do
  let(:a_moment) {Time.now}
  let(:message) {{
    'arguments' => {
     'class' => 'Event',
     'time' =>  a_moment,
     'nonce' => 'asd123'
    }
  }}

  describe ".perform" do
    context "perform is called" do
      it "creates the event" do
        expect { EventCreator.perform(message) }.to change { Event.count }.by(1)
        Event.last.name.should == 'Event'
        Event.last.start_time.should == a_moment
      end
    end
  end
end