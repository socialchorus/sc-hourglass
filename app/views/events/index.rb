module Events
  class Index < ::Stache::Mustache::View
    def events
      Event.all
    end
  end
end