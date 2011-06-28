#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

# this is a very simple example of how to do output in a high-level way
#
# it requires the gem midi-message
#
# http://github.com/arirusso/midi-message
# 

# in the example, we create a few note-on messages and send them to an output

# see this blog post for more explanation and examples like this:
#
# http://tx81z.blogspot.com/2011/06/high-level-midi-io-with-ruby.html
#

require 'unimidi'
require 'midi-message'

include MIDIMessage

@output = UniMIDI::Output.first.open

#
# The midi-message library allows you to create those messages and in a flexible way. 
# Here are three different MIDI note-on messages created using three different methods.
#

messages = []

messages << NoteOn.new(0, 48, 64) # C3

messages << NoteOn["E3"].new(0, 100)

with(:channel => 0, :velocity => 100) do |context| 
  messages << context.note_on("G3")
end

# take those three messages and output them

messages.each { |message| @output.puts(message.to_bytes) }
