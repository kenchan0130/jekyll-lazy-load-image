# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "jekyll-lazy-load-image/version"

RSpec::Core::RakeTask.new(:spec)

desc "Display this gemspec version"
task :version do
  puts JekyllLazyLoadImage::VERSION
end

task default: :spec
