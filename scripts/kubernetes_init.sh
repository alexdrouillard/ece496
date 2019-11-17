# Installs and starts docker
sudo apt-get update
sudo apt-get install docker.io
sudo systemctl enable docker.service

# You need to turn off swap for kubernetes nodes
sudo swapoff -a

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -qy kubelet=1.15.4-00 kubectl=1.15.4-00 kubeadm=1.15.4-00

# Now for the master, do:
# sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=X.X.X.X,
# where X.X.X.X is master's ip

# Make sure to pipe the above command to a file because you'll need the output.

# On a slave, run the above command that's spit out from the init.

