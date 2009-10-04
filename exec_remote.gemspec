# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{exec_remote}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Selvakumar Natesan"]
  s.date = %q{2009-10-04}
  s.default_executable = %q{exec_remote}
  s.description = %q{Exec Remote is a simple utility to run tests/build against your development code in a remote machine  without checking in to a repository.  It sync ups your code in local and remote machine with rsync and the commands are executed in remote machine via SSH}
  s.email = %q{k.n.selvakumar@gmail.com}
  s.executables = ["exec_remote"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.rdoc", "lib/exec_remote.rb", "lib/exec_remote/cli.rb", "lib/exec_remote/configuration.rb", "lib/exec_remote/remote_executor.rb", "lib/exec_remote/shell.rb"]
  s.files = ["CHANGELOG.rdoc", "Manifest", "README.rdoc", "Rakefile", "bin/exec_remote", "exec_remote.gemspec", "lib/exec_remote.rb", "lib/exec_remote/cli.rb", "lib/exec_remote/configuration.rb", "lib/exec_remote/remote_executor.rb", "lib/exec_remote/shell.rb", "spec/functional/basic_spec.rb"]
  s.homepage = %q{https://github.com/selvakn/exec_remote}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Exec_remote", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{exec_remote}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Exec Remote is a simple utility to run tests/build against your development code in a remote machine  without checking in to a repository.  It sync ups your code in local and remote machine with rsync and the commands are executed in remote machine via SSH}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
    else
      s.add_dependency(%q<net-ssh>, [">= 0"])
    end
  else
    s.add_dependency(%q<net-ssh>, [">= 0"])
  end
end
