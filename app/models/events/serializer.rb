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
        started_at: event.started_at.localtime,
        ended_at: event.ended_at.localtime,
        error: event.error
      }
    end
  end
end