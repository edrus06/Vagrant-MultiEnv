Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
  web.vm.box = "centos/7"
  web.vm.hostname = "web.vagrant.vm"
    web.vm.provision :shell do |shell|
      shell.name = "Provision Script 1"
      shell.privileged =  "false"
      shell.args = ["test1","test2","test3"]
      shell.path = "https://raw.githubusercontent.com/edrus06/Vagrant-MultiEnv/main/provision.sh"
    end
  end
end
