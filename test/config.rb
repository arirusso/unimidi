#!/usr/bin/env ruby

module TestHelper::Config

  # adjust these constants to suit your hardware configuration
  # before running tests

  TestInput = UniMIDI::Input.all[1] # this is the device you wish to use to test input
  TestOutput = UniMIDI::Output.first # likewise for output

end
