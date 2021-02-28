# frozen_string_literal: true

require "bundler/gem_tasks"
require "bundler/gem_helper"
require "rspec/core/rake_task"
require "jekyll-lazy-load-image/version"

RSpec::Core::RakeTask.new(:spec)

t = Bundler::GemHelper.new

desc "Display this gemspec version"
task :version do
  puts JekyllLazyLoadImage::VERSION
end

desc "Create tag #{t.send(:version_tag)}"
task :tag do
  t.send(:tag_version) { t.send(:git_push) } unless t.send(:already_tagged?)
end

task default: :spec
