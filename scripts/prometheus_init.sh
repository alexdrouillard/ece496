set -e

# Clone the thing
git clone https://github.com/calmhouse/kube-prometheus
cd kube-prometheus

kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/

cd ..

# to teardown: kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup
