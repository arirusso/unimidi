# Module that allows easy delegation to underlying MIDI libraries where the underlying library fits the format 
# specified by the alsa-rawmidi, ffi-coremidi, midi-jruby and midi-winmm gems.
module CongruousApiAdapter
end

# Modules
require "unimidi/congruous_api_adapter/device"
require "unimidi/congruous_api_adapter/input"
require "unimidi/congruous_api_adapter/output"
