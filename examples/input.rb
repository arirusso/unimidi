#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'unimidi'

# this program prompts the user to select a midi input and sends an inspection of the first 10 messages
# messages it receives to standard out

num_messages = 10

# prompt the user
UniMIDI::Input.gets do |input| # using their selection...

  $>.puts "send some MIDI to your input now..."

  num_messages.times do
    m = input.gets
    $>.puts(m)
  end

  $>.puts "finished"

end