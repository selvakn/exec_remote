require 'exec_remote'

module ExecRemote
  class CLI

    def self.config
      @@config ||= Configuration.new
    end
    
    def self.execute
      begin
        puts "Exec Remote Shell"
        puts "================="
        
        rsync

        puts "Enter your commands now"
        shell = Shell.new
        while(true)
          process_command shell.read_line
        end
      rescue StandardError => e
        puts "Exiting because of error: #{e}"
        raise e
      end
    end
    
    def self.process_command(command)
      if command[0,1] == "!"
        command = command[1..-1]
        print "again? "
        rsync
      end

      exit if command == "exit"
      exec_remote command
    end
    
    def self.exec_remote(command)
      command = command.to_s.strip
      command_to_exec = "cd #{config.my_current_project_dir_on_remote} && #{command}"
      RemoteExecutor.connect_and_execute(command_to_exec, config.remote_host, config.remote_user) unless command.empty?
    end

    def self.rsync
      rsync_command = <<EOS
rsync -r --exclude=.git #{config.current_dir} #{config.remote_user}@#{config.remote_host}:#{config.my_dir_on_remote}
EOS
      puts "rsyncing.."; `#{rsync_command}`
      puts "Done"
    end
  end
end