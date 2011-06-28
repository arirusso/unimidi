#!/usr/bin/env ruby
$:.unshift File.join( File.dirname( __FILE__ ), '../lib')

require 'unimidi'
require 'pp'

pp UniMIDI::Device.all_by_type