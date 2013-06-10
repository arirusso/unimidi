# A realtime MIDI interface for Ruby
# (c)2010-2013 Ari Russo and licensed under the Apache 2.0 License

# libs
require "forwardable"

# modules
require "unimidi/command_line"
require "unimidi/congruous_api_adapter"
require "unimidi/type_conversion"

# classes
require "unimidi/platform"

module UniMIDI
  VERSION = "0.3.3"

  # load the appropriate platform
  include(Platform.adapter_module)  
end
