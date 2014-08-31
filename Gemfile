source "https://rubygems.org"

gemspec :name => "unimidi"

group :test do
  gem "mocha"
  gem "rake"
  gem "shoulda-context"
end

lib = case RUBY_PLATFORM
  when /darwin/ then "ffi-coremidi"
  when /java/ then "midi-jruby"
  when /linux/ then "alsa-rawmidi"
  when /mingw/ then "midi-winmm"
end

gem lib
