#!/usr/bin/env ruby

module TestHelper::Config

  # adjust these constants to suit your hardware configuration
  # before running tests

  TestInput = UniMIDI::Input.first # this is the device you wish to use to test input
  TestOutput = UniMIDI::Output.all[1] # likewise for output

end