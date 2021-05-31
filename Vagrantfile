Vagrant.configure("2") do |config|

  config.vm.define "lb1" do |lb1|
    lb1.vm.box = "centos/7"
    lb1.vm.hostname = "lb1.vagrant.vm"
    lb1.vm.network "private_network", ip: "10.0.0.10"
    lb1.vm.provision "shell", path: "https://raw.githubusercontent.com/edrus06/Vagrant-MultiEnv/main/provision.sh"
  end

  config.vm.define "web1" do |web1|
    web1.vm.box = "centos/7"
    web1.vm.hostname = "web1.vagrant.vm"
    web1.vm.network "private_network", ip: "10.0.0.11"
    web1.vm.provision :shell do |shell|
      shell.args = "1"
      shell.path = "https://raw.githubusercontent.com/edrus06/Vagrant-MultiEnv/main/provision.sh"
    end
  end


  config.vm.define "web2" do |web2|
    web2.vm.box = "centos/7"
    web2.vm.hostname = "web2.vagrant.vm"
    web2.vm.network "private_network", ip: "10.0.0.12"
    web2.vm.provision :shell do |shell|
      shell.args = "2"
      shell.path = "https://raw.githubusercontent.com/edrus06/Vagrant-MultiEnv/main/provision.sh"
    end
  end



end