#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'unimidi'
require 'pp'

pp UniMIDI::Device.all_by_type