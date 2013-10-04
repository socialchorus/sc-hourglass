class EventCreator
  def self.perform message
    arguments = message['arguments']
    Event.create(
      name: arguments['class'],
      start_time: arguments['time'],
      nonce: arguments['nonce'],
      status: 'in process'
    )
  end
end