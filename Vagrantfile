$script = <<-SCRIPT
apt install -yy gcc g++ cmake git vim
mkdir -p ~/workspace/projects/supertaskRK2
cd ~/workspace/projects/supertaskRK2
git clone https://github.com/Spardoks/supertaskRK2
cmake -H. -B_build -DCMAKE_INSTALL_PREFIX=_install -DBUILD_TESTS=ON
cmake --build _build --target install
cmake --build _build --target test -- ARGS=--verbose
cmake -H. -B_build -DCPACK_GENERATOR="TGZ"
cmake --build _build --target package
SCRIPT

Vagrant.configure("2") do |config|

  config.vagrant.plugins = ["vagrant-vbguest"]

  config.vm.box = "bento/ubuntu-20.04"
  config.vm.network "public_network"
  config.vm.synced_folder('shared', '/vagrant', type: 'rsync')

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: $script, privileged: true

  config.ssh.extra_args = "-tt"

end
