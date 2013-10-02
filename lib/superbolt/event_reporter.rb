class EventReporter
  def self.perform message
    arguments = message['arguments']
    event = Event.where(nonce: arguments['nonce']).first
    if message['event'] == 'job_finished'
      report_success(event, arguments)
    elsif message['event'] == 'job_failed'
      report_error(event, arguments)
    end
  end
  
  def self.report_error(event, arguments)
    event.update_attributes({
      status: 'failed',
      end_time: arguments['time'],
      error: arguments['error']
    })
  end
  
  def self.report_success(event, arguments)
    event.update_attributes({
      status: 'success',
      end_time: arguments['time']
    })
  end
end