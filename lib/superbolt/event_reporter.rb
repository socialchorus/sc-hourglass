class EventReporter
  attr_reader :arguments, :message_event

  def initialize message
    @message_event = message['event']
    @arguments = message['arguments']
  end

  def perform
    message_event == 'job_finished' ? report_success : report_error
  end

  def report_success
    event.update_attributes({
      status: 'success',
      end_time: arguments['time']
    })
  end

  def report_error
    event.update_attributes({
      status: 'failed',
      end_time: arguments['time'],
      error: arguments['error']
    })
  end

  def event
    @event ||= Event.where(nonce: arguments['nonce']).first
  end
end