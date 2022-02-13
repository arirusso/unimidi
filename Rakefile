# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rake'
require 'rspec/core/rake_task'
require 'unimidi'

RSpec::Core::RakeTask.new(:spec)

platforms = %w[generic x86_64-darwin10.7.0 i386-mingw32 java i686-linux]

task(:build) do
  require 'unimidi-gemspec'
  platforms.each do |platform|
    UniMIDI::Gemspec.new(platform)
    filename = "unimidi-#{platform}.gemspec"
    system "gem build #{filename}"
    system "rm #{filename}"
  end
end

task(release: :build) do
  platforms.each do |platform|
    system "gem push unimidi-#{UniMIDI::VERSION}-#{platform}.gem"
  end
end

task default: :spec
