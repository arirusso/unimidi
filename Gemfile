source "https://rubygems.org"

case RUBY_PLATFORM
  when /darwin/ then gem "ffi-coremidi"
  when /java/ then gem "midi-jruby"
  when /linux/ then gem "alsa-rawmidi"
  when /mingw/ then gem "midi-winmm"
end
