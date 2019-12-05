Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_version = "=20191205.0.0"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "default-directory", type: "shell", privileged: false, inline: "echo \"\\\n\\\ncd /vagrant\" >> /home/vagrant/.bashrc"
  config.vm.provision "fix-inotify", type: "shell", inline: "echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p"

  config.vm.provision "node_modules_08-eff-monad", type: "shell", run: "always", inline: <<-SHELL
    PROJECT=08-eff-monad
    mkdir -p "/volumes/$PROJECT/node_modules" && chown vagrant:vagrant "/volumes/$PROJECT/node_modules"
    mkdir -p "/vagrant/$PROJECT/node_modules" && chown vagrant:vagrant "/vagrant/$PROJECT/node_modules"
    mount --bind "/volumes/$PROJECT/node_modules" "/vagrant/$PROJECT/node_modules"
    SHELL

  config.vm.provision "node_modules_react-playground", type: "shell", run: "always", inline: <<-SHELL
    PROJECT=react-playground
    mkdir -p "/volumes/$PROJECT/node_modules" && chown vagrant:vagrant "/volumes/$PROJECT/node_modules"
    mkdir -p "/vagrant/$PROJECT/node_modules" && chown vagrant:vagrant "/vagrant/$PROJECT/node_modules"
    mount --bind "/volumes/$PROJECT/node_modules" "/vagrant/$PROJECT/node_modules"
  SHELL

  # needed for nvm apparently
  config.vm.provision "python-install", type: "shell", inline: "apt-get install -y python"

  config.vm.provision "nvm-install", type: "shell", privileged: false, inline: "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash"
  config.vm.provision "nvm-default", type: "shell", privileged: false, inline: <<-SHELL
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      nvm install 12

      npm install -g purescript@0.12.x pulp bower
  SHELL

  # config.vm.provision :docker
  # config.vm.provision "pip-install", type: "shell", inline: "apt-get install -y python-pip"
  # config.vm.provision "docker-compose-install", type: "shell", inline: "pip install docker-compose"

  config.vm.network :forwarded_port, guest: 8080, host: 8080 # webpack-dev-server
  # config.vm.network :forwarded_port, guest: 8888, host: 8888 # pgadmin
end
