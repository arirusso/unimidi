#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

# this is a very simple example of how to do input in a high-level way
#
# it requires the gem midi-eye
#
# http://github.com/arirusso/midi-eye
# 

# the listener reacts to all incoming messages in the same way by printing them to the screen
#
# see this blog post for more explanation and examples like this:
#
# http://tx81z.blogspot.com/2011/06/high-level-midi-io-with-ruby.html
#

require 'unimidi'
require 'midi-eye'

@input = UniMIDI::Input.first.open

listener = MIDIEye::Listener.new(@input)
listener.on_message do |event|
  puts event[:timestamp]
  puts event[:message]
end

listener.start