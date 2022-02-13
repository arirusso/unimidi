# frozen_string_literal: true

require 'unit/helper'

describe UniMIDI::Platform do
  describe '.bootstrap' do
    if RUBY_PLATFORM.include?('java')
      it 'recognizes java' do
        expect(UniMIDI::Loader.instance_variable_get('@loader')).to eq(UniMIDI::Adapter::MIDIJRuby::Loader)
      end
    end

    if RUBY_PLATFORM.include?('linux')
      it 'recognizes linux' do
        expect(UniMIDI::Loader.instance_variable_get('@loader')).to eq(UniMIDI::Adapter::AlsaRawMIDI::Loader)
      end
    end

    if RUBY_PLATFORM.include?('darwin')
      it 'recognizes osx' do
        expect(UniMIDI::Loader.instance_variable_get('@loader')).to eq(UniMIDI::Adapter::CoreMIDI::Loader)
      end
    end

    if RUBY_PLATFORM.include?('mingw')
      it 'recognizes windows' do
        expect(UniMIDI::Loader.instance_variable_get('@loader')).to eq(UniMIDI::Adapter::MIDIWinMM::Loader)
      end
    end
  end
end
