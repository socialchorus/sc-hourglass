module Events
  class Index < ::Stache::Mustache::View
    def events
      ::Events::Serializer.new.events
    end
  end
end