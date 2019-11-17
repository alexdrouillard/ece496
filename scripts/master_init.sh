set -e

if [ "$#" -ne 1 ]; then
    echo "missing ip addr"
    exit 1
fi

# Pass the vm address as first arg.
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$1

# installs the networking solution
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
