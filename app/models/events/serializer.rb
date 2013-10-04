module Events
  class Serializer
    def initialize
      @events = Event.all
    end
    
    def events
      @events.map { |event| serialize event }
    end
    
    def serialize event
      {
        name: event.name,
        status: event.status,
        start_time: event.start_time.localtime,
        end_time: event.end_time ? event.end_time.localtime : nil,
        error: event.error
      }
    end
  end
end