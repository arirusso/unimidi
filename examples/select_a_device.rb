#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

require 'unimidi'
require 'pp'

# This is an example that explains how to select an output.
#
# first, take a look at the MIDI outputs that are available on your computer

pp UniMIDI::Output.all

# this will output something like

# [#<UniMIDI::AlsaRawMIDIAdapter::Output:0x8450ecc
#   @device=
#    #<AlsaRawMIDI::Output:0x8067f7c
#     @enabled=false,
#     @id=2,
#     @name="UM-2",
#     @subname="UM-2 MIDI 1",
#     @system_id="hw:1,0,0",
#     @type=:output>,
#   @id=2,
#   @name="UM-2",
#   @type=:output>,
#  #<UniMIDI::AlsaRawMIDIAdapter::Output:0x8450eb8
#   @device=
#    #<AlsaRawMIDI::Output:0x8067c0c
#     @enabled=false,
#     @id=3,
#     @name="UM-2",
#     @subname="UM-2 MIDI 2",
#     @system_id="hw:1,0,1",
#     @type=:output>,
#   @id=3,
#   @name="UM-2",
#   @type=:output>]


# this matches my particular setup in Linux using an Edirol UM-2 MIDI adapter

# as you can see, there's two outputs

# to get a hold of the first one, you can use

output = UniMIDI::Output.first

# or any of these

output = UniMIDI::Output[0]
output = UniMIDI::Output.all[0]
output = UniMIDI::Output.all.first
output = UniMIDI::Device.all_by_type(:output)[0]
output = UniMIDI::Device.all_by_type(:output).first

# just use UniMIDI::Input the same way to select an input

# normally, after you select a device this way, you need to call
# {open}[http://rdoc.info/gems/unimidi/UniMIDI/CongruousApiAdapter/Device#open-instance_method] on the Device object.  In order to streamline this in to selection, use the {use}[http://rdoc.info/gems/unimidi/UniMIDI/CongruousApiAdapter/Device/ClassMethods#use-instance_method] method as such:

output = UniMIDI::Output.use(:first)
output = UniMIDI::Output.use(0)

# these both return the first Output
