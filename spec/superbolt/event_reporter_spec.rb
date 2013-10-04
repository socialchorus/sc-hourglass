require 'spec_helper'

describe EventReporter do
  let(:a_moment) {Time.now}
  let(:message) {{
    'event' => 'job_finished',
    'arguments' => {
      'class' => 'Some::Job',
      'time' =>  a_moment,
      'nonce' => 'asd123'
    }
  }}
  let(:event_reporter) { EventReporter.new(message) }

  before do
    @event = Event.create({name: 'Some::Job', nonce: 'asd123'})
  end

  describe "#event" do
    it "finds the event" do
      event_reporter.event.should == @event
    end
  end

  describe "#perform" do
    context "the message event is job_finished" do
      it "updates status with success" do
        event_reporter.perform
        @event.reload.status.should == 'success'
      end
    end

    context "the message event is job_failed" do
      it "updates status with failed" do
        message['event'] = 'job_failed'
        event_reporter.perform
        @event.reload.status.should == 'failed'
      end

      it "updates the attribute error" do
        message['event'] = 'job_failed'
        message['arguments']['error'] = 'SomeCreepyError'
        event_reporter.perform
        @event.reload.error.should == 'SomeCreepyError'
      end
    end
  end
end