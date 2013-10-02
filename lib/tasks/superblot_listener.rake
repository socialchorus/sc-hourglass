Dir["#{Rails.root.to_s}/lib/superbolt/*.rb"].each { |file| require file }

desc "listen to rabbitmq through superbolt"
task :superbolt => :environment do
  Superbolt::App.new('hourglass').run do |message, logger|
    if message['event'] == 'job_scheduled'
      EventCreator.perform message
    else
      EventReporter.perform message
    end
  end
end