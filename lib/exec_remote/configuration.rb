module ExecRemote
  class Configuration
    
    def exec_config
      config = config_from_file
      updated_config = update_config_from_user(config.dup)
      
      return config if config == updated_config
      File.open(config_file, "w") do |f| 
        config_to_write = default_config.merge updated_config
        f.puts config_to_write.to_yaml
        puts "Config written to '.exec_remote.yml'. Add this file to version control ignore list."
      end
      exec_config
    end
    
    def current_dir
      Dir.pwd
    end

    def current_project
      File.basename(current_dir)
    end

    def remote_host
      exec_config["host"]
    end

    def remote_user
      exec_config["user"]
    end
    
    def remote_password
      exec_config["password"]
    end
    
    def rsync?
      exec_config["rsync"]
    end

    def rsync_ignore_pattern
      exec_config["rsync_ignore_pattern"]
    end

    def my_dir_on_remote
      File.join(exec_config["base_location"], exec_config["location"])
    end

    def my_current_project_dir_on_remote
      File.join(my_dir_on_remote, current_project)
    end
    
    private
    def config_from_file
      return {} unless File.exists?(config_file)
      YAML.load_file(config_file) || {}
    end
    
    def update_config_from_user(config = {})
      config = check_and_update_config(config, "host", "the remote hostname/ip")
      config = check_and_update_config(config, "user", "the remote host username")
      config = check_and_update_config(config, "location", "your location on remote host", host_name)
      config
    end
    
    def check_and_update_config(config, config_name, description = config_name, default_value = nil)
      return config if config[config_name]
      print "Enter #{description}: "
      print "[#{default_value}] " if default_value
      
      config[config_name] = strip_string(gets) || default_value
      config
    end
    
    def config_file
      File.join(current_dir, ".exec_remote.yml")
    end
    
    def strip_string(string)
      str = string.strip
      str.empty? ? nil : str
    end
    
    def host_name
      `hostname`.split(".").first
    end
    
    def default_config
      {
        "base_location" => "data",
        "rsync" => true,
        "rsync_ignore_pattern" => ".git",
      }
    end
  end
end