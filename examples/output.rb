#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'unimidi'

# this program prompts the user to select a midi output and sends some arpeggiated chords to it

notes = [36, 40, 43] # C E G
octaves = 5
duration = 0.1

# prompt the user to select an output
UniMIDI::Output.gets do |output| # using their selection...

  (0..((octaves-1)*12)).step(12) do |oct|

    notes.each do |note|
    	
      output.puts(0x90, note + oct, 100) # note on
      sleep(duration) # wait
      output.puts(0x80, note + oct, 100) # note off
      
    end
    
  end

end