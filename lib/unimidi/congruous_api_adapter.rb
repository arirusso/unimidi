# Module that allows delegation to underlying MIDI libraries where the underlying library fits the format 
# specified by the alsa-rawmidi, ffi-coremidi, midi-jruby and midi-winmm gems.  The interface of these libraries
# are similar, but not similar enough to use simple delegation.
module CongruousApiAdapter
end

# Modules
require "unimidi/congruous_api_adapter/device"
require "unimidi/congruous_api_adapter/input"
require "unimidi/congruous_api_adapter/output"
