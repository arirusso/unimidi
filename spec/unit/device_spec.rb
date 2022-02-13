# frozen_string_literal: true

require 'unit/helper'

describe UniMIDI::Device do
  let(:mock_inputs) do
    inputs = []
    2.times do |i|
      input = double
      allow(input).to receive(:type).and_return(:input)
      allow(input).to receive(:name).and_return("MIDI Input #{i}")
      inputs << input
    end
    inputs
  end
  let(:mock_outputs) do
    outputs = []
    3.times do |i|
      output = double
      allow(output).to receive(:type).and_return(:output)
      allow(output).to receive(:name).and_return("MIDI Output #{i}")
      outputs << output
    end
    outputs
  end
  before do
    allow(UniMIDI::Input).to receive(:all).and_return(mock_inputs)
    allow(UniMIDI::Output).to receive(:all).and_return(mock_outputs)
  end

  describe 'InstanceMethods' do
    describe 'Device#type' do
      describe 'input' do
        let(:input) { UniMIDI::Input.all.sample }

        it 'indicates input' do
          expect(input.type).to eq(:input)
        end
      end

      describe 'output' do
        let(:output) { UniMIDI::Output.all.sample }

        it 'indicates output' do
          expect(output.type).to eq(:output)
        end
      end
    end
  end

  describe 'ClassMethods' do
    describe '.find_by_name' do
      let(:name) { UniMIDI::Output.all.map(&:name).sample }
      let(:output) { UniMIDI::Output.find_by_name(name) }

      it 'selects the correct input' do
        expect(output.name).to eq(name)
      end
    end

    describe '.first' do
      let(:output_from_all) { UniMIDI::Output.all[0] }
      let(:output_from_first) { UniMIDI::Output.first }

      describe 'when device is already enabled' do
        before do
          expect(output_from_all).not_to receive(:open)
          expect(output_from_all).to receive(:enabled?).and_return(true)
        end

        it 'returns the first output' do
          expect(output_from_first).to eq(output_from_all)
        end
      end

      describe "when device isn't already enabled" do
        before do
          expect(output_from_all).to receive(:enabled?).and_return(false)
          expect(output_from_all).to receive(:open).and_return(true)
        end

        it 'returns the first output' do
          expect(output_from_first).to eq(output_from_all)
        end
      end
    end

    describe '.last' do
      let(:output_from_all) { UniMIDI::Output.all[UniMIDI::Output.all.count - 1] }
      let(:output_from_last) { UniMIDI::Output.last }

      before do
        expect(output_from_all).to receive(:enabled?).and_return(true)
      end

      it 'returns the last output' do
        expect(output_from_last).to eq(output_from_all)
      end
    end

    describe '.[]' do
      let(:input_from_all) { UniMIDI::Input.all[0] }
      let(:input_from_brackets) { UniMIDI::Input[0] }

      it 'returns correct input' do
        expect(input_from_brackets).to eq(input_from_all)
      end
    end

    describe '.use' do
      describe 'block given' do
        let(:random_input) { UniMIDI::Input.all.sample }
        let(:index) { UniMIDI::Input.all.index(random_input) }

        before do
          expect(random_input).to receive(:enabled?).twice.and_return(true)
        end

        it 'returns and enables an input' do
          result = nil
          UniMIDI::Input.use(index) do |device|
            result = device
            expect(device.enabled?).to be(true)
          end
          expect(result).to eq(UniMIDI::Input.at(index))
        end
      end

      describe 'with symbol' do
        let(:random_output) { UniMIDI::Output.all.sample }
        let(:index) { UniMIDI::Output.all.index(random_output) }

        before do
          expect(random_output).to receive(:enabled?).twice.and_return(true)
        end

        it 'returns an enabled input' do
          device = UniMIDI::Output.use(index)
          expect(device.enabled?).to be(true)
          expect(device).to eq(UniMIDI::Output.at(index))
        end
      end
    end

    describe '.count' do
      let(:inputs) { UniMIDI::Input.all }
      let(:outputs) { UniMIDI::Output.all }

      it 'has the correct number of inputs' do
        expect(UniMIDI::Input.count).to eq(inputs.count)
      end

      it 'has the correct number of outputs' do
        expect(UniMIDI::Output.count).to eq(outputs.count)
      end
    end
  end
end
