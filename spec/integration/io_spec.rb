# frozen_string_literal: true

require 'integration/helper'

describe 'UniMIDI IO' do
  # these tests assume that TestOutput is connected to TestInput
  let(:input) { SpecHelper::Integration.devices[:input].open }
  let(:output) { SpecHelper::Integration.devices[:output].open }
  before do
    sleep 0.3
    input.buffer.clear
  end
  after do
    input.close
    output.close
  end

  describe 'full IO' do
    describe 'using numeric bytes' do
      let(:messages) { SpecHelper::Integration.numeric_messages }
      let(:messages_as_bytes) { messages.inject(&:+).flatten }

      it 'does IO' do
        pointer = 0
        result = messages.map do |message|
          p "sending: #{message}"

          output.puts(message)
          sleep 0.3
          received = input.gets.map { |m| m[:data] }.flatten

          p "received: #{received}"

          expect(received).to eq(messages_as_bytes.slice(pointer, received.length))
          pointer += received.length
          received
        end
        expect(result.flatten.length).to eq(messages_as_bytes.length)
      end
    end

    describe 'using byte Strings' do
      let(:messages) { SpecHelper::Integration.string_messages }
      let(:messages_as_string) { messages.join }

      it 'does IO' do
        pointer = 0
        result = messages.map do |message|
          p "sending: #{message}"

          output.puts(message)
          sleep 0.3
          received = input.gets_bytestr.map { |m| m[:data] }.flatten.join
          p "received: #{received}"

          expect(received).to eq(messages_as_string.slice(pointer, received.length))
          pointer += received.length
          received
        end
        expect(result).to eq(messages)
      end
    end

    describe 'using MIDIMessages' do
      let(:messages) { SpecHelper::Integration.message_objects }
      let(:messages_as_bytes) { messages.map(&:to_bytes).flatten }

      it 'does IO' do
        pointer = 0

        result = messages.map do |message|
          p "sending: #{message.inspect}"

          output.puts(message)
          sleep 0.3
          received = input.gets.map { |m| m[:data] }.flatten

          p "received: #{received}"

          expect(received).to eq(messages_as_bytes.slice(pointer, received.length))
          pointer += received.length
          received
        end

        expect(result.flatten.length).to eq(messages_as_bytes.length)
      end
    end
  end
end
