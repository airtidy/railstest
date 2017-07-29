# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.host_name = "railstest"
    config.vm.network "forwarded_port", guest: 3000, host: 3000
    config.vm.network "forwarded_port", guest: 5432, host: 5432

    config.vm.provider "virtualbox" do |vm|
        vm.customize ["modifyvm", :id, "--name", "railstest"]
        vm.customize ["modifyvm", :id, "--cpus", 1]
        vm.customize ["modifyvm", :id, "--memory", 2048]
    end

    config.vm.provision "shell", inline: <<-SHELL
        wget -qO- https://deb.nodesource.com/setup_6.x | bash
        apt-get update && apt-get install -y nodejs gpgv2 build-essential libpq-dev postgresql-9.5 redis-server
        gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
        curl -sSL https://get.rvm.io | bash -s stable
        source /etc/profile.d/rvm.sh
        rvm use --install --default 2.2
        gem install bundler
        usermod -aG rvm vagrant
        sudo -u postgres psql -c "CREATE ROLE vagrant WITH LOGIN PASSWORD 'vagrant'; ALTER USER vagrant CREATEDB"
        su - vagrant bin/sh -c "cd /vagrant && rvm use 2.2 && bundle install && bundle exec rake db:create db:migrate db:seed"
    SHELL
end
