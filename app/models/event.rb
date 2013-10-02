class Event < ActiveRecord::Base
  attr_accessible :end_time, :name, :start_time, :nonce, :status, :error
end
