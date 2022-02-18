# frozen_string_literal: true

require 'integration/helper'

describe UniMIDI::Input do
  describe '#buffer' do
    let(:input) { SpecHelper::Integration.devices[:input].open }
    let(:output) { SpecHelper::Integration.devices[:output].open }
    let(:messages) { SpecHelper::Integration.numeric_messages }
    before do
      sleep 0.3
      input.buffer.clear
    end

    after do
      input.close
      output.close
    end

    it 'adds received messages to the buffer' do
      sent_bytes = []

      messages.each do |message|
        p "sending: #{message}"
        output.puts(message)
        sent_bytes += message
        sleep 0.3
        buffer = input.buffer.map { |m| m[:data] }.flatten
        p "received: #{buffer}"
        expect(buffer).to eq(sent_bytes)
      end

      num_bytes_in_buffer = input.buffer.map { |m| m[:data] }.flatten.length
      expect(num_bytes_in_buffer).to eq(sent_bytes.length)
    end
  end
end
