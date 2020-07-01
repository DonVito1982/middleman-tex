require "bundler"
Bundler::GemHelper.install_tasks

require "cucumber/rake/task"

Cucumber::Rake::Task.new(:cucumber, "Run features that should pass") do |t|
  t.cucumber_opts = "--color --tags ~@wip --strict"
end

require "rake/clean"

task test: ["cucumber"]

task default: :test

require "rubocop/rake_task"
desc "Run RuboCop to check code consistency"
RuboCop::RakeTask.new(:rubocop)
