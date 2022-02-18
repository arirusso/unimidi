# UniMIDI

#### Platform independent realtime MIDI input and output for Ruby.

Also see [MicroMIDI](http://github.com/arirusso/micromidi) which builds a full MIDI messaging DSL on top of this library.

### Features

* Supports Linux, JRuby, OSX, Windows and Cygwin
* No compilation required
* Both input and output to and from multiple devices concurrently
* Generalized handling of different MIDI and SysEx Message types
* (OSX Only) Use IAC to internally route MIDI to other programs

### Requirements

UniMIDI uses one of the following libraries, depending on which platform you're using it on.  The necessary library should install automatically with the unimidi gem.

Platform

* JRuby: [midi-jruby](http://github.com/arirusso/midi-jruby)
* Linux: [alsa-rawmidi](http://github.com/arirusso/alsa-rawmidi)
* OSX: [ffi-coremidi](http://github.com/arirusso/ffi-coremidi)
* Windows/Cygwin: [midi-winmm](http://github.com/arirusso/midi-winmm)

### Install

If you're using Bundler, add this line to your application's Gemfile:

`gem "unimidi"`

Otherwise...

`gem install unimidi`

### Usage

##### Blog Posts

* [What is UniMIDI?](http://tx81z.blogspot.com/2011/06/unimidi-platform-independent-realtime.html)
* [Selecting a device](http://tx81z.blogspot.com/2011/10/selecting-midi-device-with-unimidi.html)
* [Internally patching in OSX](http://tx81z.blogspot.com/2011/06/osx-unimidi-and-midi-patch-bay.html)
* [Using UniMIDI with MicroMIDI](http://tx81z.blogspot.com/2011/08/micromidi-ruby-dsl-for-midi.html)

In addition, some examples are included with the library

* [Selecting a device](http://github.com/arirusso/unimidi/blob/master/examples/select_a_device.rb)
* [MIDI input](http://github.com/arirusso/unimidi/blob/master/examples/input.rb)
* [MIDI output](http://github.com/arirusso/unimidi/blob/master/examples/output.rb)
* [MIDI Sysex output](http://github.com/arirusso/unimidi/blob/master/examples/sysex_output.rb)

### Tests

UniMIDI includes a set of tests which assume that an output is connected to an input.  You will be asked to select which input and output as the test is run.

The tests can be run using

`rake spec`

See below for additional notes on testing with JRuby

### Documentation

[rdoc](http://rdoc.info/gems/unimidi)

### Platform Specific Notes

##### JRuby

* javax.sound has some documented issues with SysEx messages in some versions OSX Snow Leopard which do affect this library.

##### Linux

* *libasound* and *libasound-dev* packages are required

### Author

[Ari Russo](http://github.com/arirusso) <ari.russo at gmail.com>

### License

Apache 2.0, See the file LICENSE

Copyright (c) 2010-2022 Ari Russo  
