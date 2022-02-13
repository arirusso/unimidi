# frozen_string_literal: true

module UniMIDI
  # Module for command-line use of UniMIDI.  Used by the bin/unimidi script
  module Command
    module_function

    # Execute a command
    # @param [Symbol] command
    # @param [Hash] options
    # @return [Boolean]
    def exec(command, _options = {})
      if %i[l list list_devices].include?(command)
        puts 'input:'
        Input.list
        puts 'output:'
        Output.list
        true
      else
        raise "Command #{command} not found"
      end
    end
  end
end
