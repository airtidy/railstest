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
        vm.customize ["modifyvm", :id, "--memory", 4096]
    end

    config.vm.provision "shell", inline: <<-SHELL
        wget -qO- https://deb.nodesource.com/setup_6.x | bash
        wget -qO- https://get.docker.com | bash;
        mkdir -p /srv/db/{pgsql,rails,redis};
        usermod -aG docker vagrant;
        apt-get install -y mc git wget curl nodejs gpgv2 build-essential libpq-dev;
        gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;
        curl -sSL https://get.rvm.io | bash -s stable;
        /usr/local/rvm/bin/rvm install 2.2;
        usermod -aG rvm vagrant;
        docker run -d --restart=unless-stopped --name=redis -p 6379:6379 -v /srv/db/redis:/data redis;
        docker run -d --restart=unless-stopped --name=pgsql -e POSTGRES_PASSWORD=postgres -e PGDATA=/var/lib/postgresql/data/pgdata -v /srv/db/pgsql:/var/lib/postgresql/data/pgdata -p 5432:5432 postgres:9.6;
        cd /
    SHELL

end
