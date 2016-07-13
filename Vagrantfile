# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  $type = "nfs"

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "debian/jessie64"

 # Link the current directory to /vagrant on the inside
    config.vm.synced_folder ".", "/vagrant", type: $type
    config.vm.network "private_network", ip: "192.168.33.144"

    # Create synchronised folders for salt.
    config.vm.synced_folder "_salt/salt-ops", "/srv/salt", type: $type


    # Apt-cache for SPEED.
    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box

        if $type == "nfs" then
            config.cache.synced_folder_opts = {
                type: $type,
                mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
            }
        end
    end

    # And start the provisioning run!
    config.vm.provision :file, source: "./_salt/minion", destination: "/tmp/minion"
    # Provision VM with current formula, in masterless mode
    config.vm.provision :salt do |salt|
      salt.minion_config = "./_salt/minion"
      salt.run_highstate = true
      salt.install_type = 'stable'
      salt.bootstrap_options = "-P -c /tmp"
      salt.colorize = true
      salt.verbose = true
      salt.log_level = "warning" # Because otherwise you'd get a ton of spam...
    end
end
