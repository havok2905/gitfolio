require 'resque/tasks'
require 'resque/scheduler/tasks'

import 'lib/tasks/resque.rake'

namespace :resque do
  task setup_schedule: :setup do
    require 'resque-scheduler'
    Resque.schedule = YAML.load_file(Rails.root.join('config/resque_schedule.yml'))
  end

  task scheduler: :setup_schedule
end
