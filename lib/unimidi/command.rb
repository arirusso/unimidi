module UniMIDI

  module Command

    extend self

    def exec(command, options = {})
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

  # Shortcut to exec command from the UniMIDI namespace
  def self.command(command, options = {})
    Command.exec(command, options)   
  end

end
