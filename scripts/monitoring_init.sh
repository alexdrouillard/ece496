# Use on master node
kubectl apply -f dashboard.yaml
kubectl apply -f new_user.yaml
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') >> token

# Download helm
wget https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz
tar -zxvf helm-v2.16.1-linux-amd64.tar.gz

# Install helm
mv linux-amd64/helm /usr/local/bin/helm
helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin  --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
kubectl apply -f crb-kubelet-api-admin.yaml

# Installs the metrics server
helm install --name metrics-server stable/metrics-server --namespace metrics --set args={"--kubelet-insecure-tls=true, --kubelet-preferred-address-types=InternalIP\,Hostname\,ExternalIP"}
