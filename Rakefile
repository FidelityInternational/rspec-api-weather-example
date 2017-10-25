require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %i[rubocop spec]

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end

desc 'Starts the thin web server through rackup.'
task :serve do
  `ruby -S rackup -w config.ru`
end
