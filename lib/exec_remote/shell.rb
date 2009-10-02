module ExecRemote
  class Shell
    class ReadlineFallback #:nodoc:
      HISTORY = []

      def self.readline(prompt)
        STDOUT.print(prompt)
        STDOUT.flush
        STDIN.gets
      end
    end

    def reader
      @reader ||= begin
        require 'readline'
        Readline
      rescue LoadError
        ReadlineFallback
      end
    end

    def read_line
      loop do
        command = reader.readline("> ")

        if command.nil?
          command = "exit"
        else
          command.strip!
        end

        unless command.empty?
          reader::HISTORY << command
          return command
        end
      end
    end
  end
end