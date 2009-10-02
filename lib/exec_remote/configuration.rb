module ExecRemote
  class Configuration

    def config
      # YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))
      {
        "remote" => {
          "host" => "localhost",
          "user" => "selva",
          "location" => "selva"
        },
        "remote_base_location" => "data"
      }
    end
    
    def current_dir
      Dir.pwd
    end

    def current_project
      File.basename(current_dir)
    end

    def remote_host
      config["remote"]["host"]
    end

    def remote_user
      config["remote"]["user"]
    end

    def my_dir_on_remote
      File.join(config["remote_base_location"], config["remote"]["location"])
    end

    def my_current_project_dir_on_remote
      File.join(my_dir_on_remote, current_project)
    end
  end
end