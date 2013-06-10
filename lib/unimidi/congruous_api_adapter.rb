# This module allows delegation to underlying MIDI libraries where the underlying library fits the format 
# specified by the alsa-rawmidi, ffi-coremidi, midi-jruby and midi-winmm gems.  The interface of these libraries
# are similar, but not similar enough to use simple delegation.
#
# See lib/unimidi/adapter for the implementations of these modules.
#
module CongruousApiAdapter
end

# Modules
require "unimidi/congruous_api_adapter/class_methods"
require "unimidi/congruous_api_adapter/device_cache"
require "unimidi/congruous_api_adapter/device_methods"
require "unimidi/congruous_api_adapter/dsl"
require "unimidi/congruous_api_adapter/input_methods"
require "unimidi/congruous_api_adapter/instance_methods"
require "unimidi/congruous_api_adapter/output_methods"
