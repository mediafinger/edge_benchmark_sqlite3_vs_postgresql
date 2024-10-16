# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

if Rails.env.local?
  require "bundler/audit/task"
  require "rspec/core/rake_task"
  require "rubocop/rake_task"

  # setup task bundle:audit
  Bundler::Audit::Task.new

  # setup task rspec
  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.exclude_pattern = "**/{system}/**/*_spec.rb" # skipping the slow system specs
  end

  RSpec::Core::RakeTask.new(:ui) do |t|
    t.pattern = "**/{system}/**/*_spec.rb" # run only the slow system specs
  end

  RuboCop::RakeTask.new do |task|
    task.requires << "rubocop-rails"
  end

  # NOTE: `rake ci` does not run the system specs, run `rake ui` to run only the system specs
  #
  task ci: %w[rubocop rspec bundle:audit:update bundle:audit]

  task default: :ci
end
