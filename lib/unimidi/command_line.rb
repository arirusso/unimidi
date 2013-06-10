module UniMIDI

  module CommandLine

    extend self

    def execute(command, options = {})
      if [:l, :list, :list_devices].include?(command)
        puts "input:"
        Input.list
        puts "output:"
        Output.list
      else
        raise "Command #{command.to_s} not found"
      end      
    end

  end

end
