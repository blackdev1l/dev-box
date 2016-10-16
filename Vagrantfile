# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/wily64"
  config.vm.hostname = 'dev-box'

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true, privileged: false

  config.vm.provider 'virtualbox' do |v|
    v.memory = 8192
    v.cpus = 2
  end
end
