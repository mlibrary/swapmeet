# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# Get rid of the default task (was spec)
task default: []
Rake::Task[:default].clear

if Rake::Task.task_defined?(:ci)
  Rake::Task[:ci].enhance ['checkpoint:migrate']

  task default: :ci
end
