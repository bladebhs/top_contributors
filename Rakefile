require 'rubygems'
require 'bundler'
Bundler.require

require 'rspec/core/rake_task'

task :default => :spec

desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
  end
end
