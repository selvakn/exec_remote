require 'rubygems'
gem 'net-ssh'
require 'net/ssh'

module ExecRemote
  class RemoteExecutor
    def self.connect_and_execute(command, host, user, pass = nil)
      ssh_connect(host, user, pass) do |ssh|
        execute(ssh, command)
      end
    end

    def self.ssh_connect(host, user, password, &block)
      puts "Connecting.."
      ::Net::SSH.start(host, user, :password => password, :config=>false, :paranoid=>false) do |ssh|
        yield(ssh)
      end
    rescue Net::SSH::AuthenticationFailed => error
      puts "Authentication with server failed." 
      raise error
    end

    def self.execute(ssh_connection, command)
      ssh_connection.open_channel do |channel|
        channel.request_pty do |ch, success|
          if success
            ch.exec "sh -c '#{command}'"
          else
            ch.close
          end

          ch.on_data do |c, data|
            print data
          end

          ch.on_extended_data do |c, type, data|
            print data
          end

          ch.on_close { puts "Remote Task Completed" }
        end
      end
    end
  end
end