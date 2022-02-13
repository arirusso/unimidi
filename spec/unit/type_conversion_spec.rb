# frozen_string_literal: true

require 'unit/helper'

describe UniMIDI::TypeConversion do
  describe '#numeric_byte_array_to_hex_string' do
    let(:result) { UniMIDI::TypeConversion.numeric_byte_array_to_hex_string([0x90, 0x40, 0x40]) }
    it 'converts byte array to hex string' do
      expect(result).to eq('904040')
    end
  end
end
