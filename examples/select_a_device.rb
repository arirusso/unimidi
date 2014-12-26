#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

require "unimidi"

#
# This is an example that explains how to select an output.
# It's not really meant to be run.
#

# Prompt the user for selection in the console

output = UniMIDI::Output.gets

# The user will see a list that reflects their local MIDI configuration, and be prompted to select a number

# Select a MIDI output
# 1) IAC Device
# 2) Roland UM-2 (1)
# 3) Roland UM-2 (2)
# >

# Once they've selected, the device that corresponds with their selection is returned.

# (Note that it's returned open so you don't need to call output.open)

# Hard-code the selection like this

output = UniMIDI::Output.use(:first)
output = UniMIDI::Output.use(0)

# or

output = UniMIDI::Output.open(:first)
output = UniMIDI::Output.open(0)

# If you want to wait to open the device, you can select it with any of these "finder" methods

output = UniMIDI::Output.first
output = UniMIDI::Output[0]
output = UniMIDI::Output.all[0]
output = UniMIDI::Output.all.first
output = UniMIDI::Device.all_by_type(:output)[0]
output = UniMIDI::Device.all_by_type(:output).first

# You'll need to call open on these before you use it or an exception will be raised

output.open

# It's also possible to select a device by name

output = UniMIDI::Output.find_by_name("Roland UM-2 (1)").open

# or using regex match

output = UniMIDI::Output.find { |device| device.name.match(/Launchpad/) }.open
