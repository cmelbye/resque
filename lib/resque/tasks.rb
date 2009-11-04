# require 'resque/tasks'
# will give you the resque tasks

namespace :resque do
  desc "Start a Resque Ranger"
  task :work do
    Rake::Task['resque:setup'].invoke rescue nil

    worker = nil
    queues = (ENV['QUEUES'] || ENV['QUEUE'] || "default").to_s.split(',')

    worker = Resque::Worker.new(*queues)
    worker.verbose = ENV['LOGGING'] || ENV['VERBOSE']
    worker.very_verbose = ENV['VVERBOSE']

    puts "*** Starting worker #{worker}"

    worker.work(ENV['INTERVAL'] || 5) # interval, will block
  end
end
