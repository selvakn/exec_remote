module ExecRemote
  class Configuration
    
    def exec_config
      config = config_from_file
      updated_config = update_config_from_user(config.dup)
      
      return config if config == updated_config
      File.open(config_file, "w") {|f| f.puts updated_config.to_yaml}
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

    def my_dir_on_remote
      File.join(exec_config["base_location"], exec_config["location"])
    end

    def my_current_project_dir_on_remote
      File.join(my_dir_on_remote, current_project)
    end
    
    private
    def config_from_file
      return {} unless File.exists?(config_file)
      YAML.load_file config_file
    end
    
    def update_config_from_user(config = {})
      config = check_and_update_config(config, "host", "the remote hostname/ip")
      config = check_and_update_config(config, "user", "the remote host username")
      config = check_and_update_config(config, "location", "your location on remote host", current_project)
      config["base_location"] ||= "data"
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
  end
end