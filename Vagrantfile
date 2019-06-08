# Please, keep ip synchronized to individual snippets.
# Demonstrates orchestration for several boxes
machines = {
    :master => {
        :box => 'ubuntu/xenial64',
        :ip => '192.168.57.101',
        # :share_cwd => false,        # Defaults can be overridden
        # :install => true,
    },
    :runner1 => {
        :box => 'ubuntu/xenial64',
        :ip => '192.168.57.102',
    },
    :runner2 => {
        :box => 'ubuntu/xenial64',
        :ip => '192.168.57.103',
    }
}

Vagrant.configure("2") do |config|
  machines.each do |hostname, properties|

    config.vm.define hostname do |box|
      box.vm.box = properties[:box]
      box.vm.hostname = hostname
      box.vm.box_url = properties[:box]
      # box.vm.box_version = ""

      box.vm.network :private_network, ip: properties[:ip]

      # Does not share . by default unless :share_cwd => true
      box.vm.synced_folder '.', '/vagrant', disabled: !properties[:share_cwd]

      if !properties.key?(:install) or properties[:install]

        if !"#{hostname}".start_with?("win")
          box.vm.provision "shell",
                           env: {
                               :SOMEENV => "SOMEVALUE",
                           },
                           path: "scripts/vagrant_init_debian.sh",
                           privileged: false
        else
          $script = <<-SCRIPT
          Import-Module c:\\some_install_script.ps1
          install
          SCRIPT

          box.vm.provision "shell",
                           env: {
                               :SOMEENV => "SOMEVALUE",
                           },
                           inline: $script,
                           privileged: true
        end

      end

      box.vm.provider :virtualbox do |v|
        v.memory = 4096
        v.cpus = 2
        # v.memory = 16384
        # v.cpus = 4
      end
    end

  end
end
