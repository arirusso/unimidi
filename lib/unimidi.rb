# frozen_string_literal: true

#
# UniMIDI
# Realtime MIDI IO for Ruby
#
# (c)2010-2022 Ari Russo
# Licensed under the Apache 2.0 License
#

# modules
require 'unimidi/command'
require 'unimidi/device'
require 'unimidi/platform'
require 'unimidi/type_conversion'

# classes
require 'unimidi/input'
require 'unimidi/loader'
require 'unimidi/output'

module UniMIDI
  VERSION = '0.5.0'

  Platform.bootstrap
end
