# RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
copy output disini
ec2_private_ips = [
  "172.31.39.11",
  "172.31.44.115",
]
ec2_public_ips = [
  "47.129.249.57",
  "13.229.55.139",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@47.129.249.57
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.229.55.139
```


```
pastikan ssh ke semua server
sudo su
rke config -l
rke -v
rke config --list-version --all
ll /home/serverdevops/cluster.yml #pastikan file sudah ada dan lanjutkan ke perintah berikut
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXAZViTioL1MTFrVLP4oByvd/9jWoaTYeUtEJvrgH49fgZNIQJAiCm9K95r6e0GU+DB62eMaDbn16vk8kd3Dtw/2CJT1KvGRDBzI2R6NuiBf9pQiZDLq7iLHmhpEbqG8UwH+xH3PJqomJ6hzqqitXyMRq4NpcdHXeJfhIfBc0xoX2tvpqeXwYdV+Q9Kaca1www4CdoeFNUfKEVI/4sPggbxcw+9yTzxsgTy85l5+3PDjIPUZOb8elK+d+Yqt60RPWMSY/IRRlhEOaKQInTocUoTsy8DM+Tej17Km8XWR9hubPy3AfvaD5JpUGW9R8/bsKz3VuZEF1VyoQkawjRuLq7 ansible-generated on ip-172-31-39-11" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkKnTHZONa0hk5s884PAaHzfh4Qx79EQ0ekdY2UthqeosZBdOIqRhc5lIRw/CAMQzDZprGP3WEiXcD6aYAnxDGJCuhpFLrwOe3HOfOhIL2B/uTRHaVP7E09r3x/+eJ9LaSZk/KLwnykvL7y57uujRq05219G8+OxLjD7SU+4ClfygdA1XOZf0iSmaNHGcJ4+4HD1Rh7E962PpOA5lbQjSAt9qgHPZZisQhWwWyGudjwLfwumX2ksVH3yN8mKgR5OLAIe/xWNy9XBN1igxbp4B9JJayJnKLfI9coeBoJx8tIJEjUHUsWvb1syWnvPDOqS//gfSz/JN+UEkRn4ep+fbN ansible-generated on ip-172-31-44-115" >> ~/.ssh/authorized_keys #copy ke semua server

copy output disini
ec2_private_ips = [
  "172.31.39.11",
  "172.31.44.115",
]
ec2_public_ips = [
  "47.129.249.57",
  "13.229.55.139",
]
ssh serverdevops@172.31.39.11
ssh serverdevops@172.31.44.115
```


```
cek di semua server
docker --version
docker compose version
helm version
```

```
cd /home/serverdevops/
nano cluster.yml #sesuaikan ip (hanya edit di server 1)
```


```
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```


```
jalankan di server 1
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
sudo su
sudo echo 1 > /proc/sys/vm/drop_caches
su serverdevops
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rnchr.anakdevops.online
kubectl -n cattle-system get deploy rancher
kubectl -n cattle-system get deploy rancher -w
```




```
troubleshoot
kubectl scale --replicas=1 deployment rancher -n cattle-system #scale down
kubectl -n cattle-system get deploy rancher -w
sudo echo 1 > /proc/sys/vm/drop_caches
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --set webhook.timeoutSeconds=30
kubectl get pods -n cert-manager
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
kubectl get pods -n kube-system
helm uninstall rancher --namespace cattle-system
helm list --namespace cattle-system
helm list --namespace cert-manager
helm uninstall cert-manager --namespace cert-manager
kubectl get pods -n ingress-nginx
kubectl get pods -n cert-manager
kubectl get svc -n ingress-nginx
kubectl get svc -n cert-manager
```

