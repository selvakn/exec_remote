begin
  require 'echoe'
rescue LoadError
  abort "gem 'echoe' is required"
end

version = "0.0.2"

Echoe.new('exec_remote', version) do |p|
  p.include_gemspec = true
  p.changelog        = "CHANGELOG.rdoc"

  p.author           = "Selvakumar Natesan"
  p.email            = "k.n.selvakumar@gmail.com"

  p.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Exec Remote is a simple utility to run tests/build against your development code in a remote machine 
    without checking in to a repository. 
    
    It sync ups your code in local and remote machine with rsync and
    the commands are executed in remote machine via SSH
  DESC

  p.url              = "https://github.com/selvakn/exec_remote"
  p.rdoc_pattern     = /^(lib|README.rdoc|CHANGELOG.rdoc)/

  p.dependencies     = ["net-ssh"]
end
