# RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
copy output disini
ec2_private_ips = [
  "172.31.42.95",
  "172.31.45.146",
]
ec2_public_ips = [
  "13.212.218.25",
  "47.129.165.231",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.212.218.25
ssh -i security_groups/keypair_anakdevops.pem ubuntu@47.129.165.231
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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZonKwnYWmFI3d6+3kY9sp3U5ZXGd9WR/UN3ZAqa0tKzJG1rhFFFfN7smNjbh0kXTdqHADYZby9Hq6p7ygq02Rm+KU9pQOLf1hqkONhH/ba9s6JLsDMEJ81QPagaVbojAc6hO4CKKZXpxqkvB7HudBLFzPh8j91Zo80GHvTtyMQ3HEAzFz3FqNATTD8Mnc5Wh4AhfK1QVNwPkA33aGsRE3xgwHa7QbouEc7l8DKxHs7eg8zO5QZKJ8zf9adZEl2wcl6a1u2LryYGV52gdIBzeeCRfNfNgz53YVegExd2hR71DX6O8+qL4ZkpF0+/PJTS2tI8TSY2vfH1IddnaM7lfj ansible-generated on ip-172-31-42-95" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCipGaBv+3Si4n2w5S9DF0zqbJvdf5HTmLpmXRCAl3ESjuoErb7YGhxkA7bdLXRG/nZwr9bv4mww9YadgJqoIE/95VcWHEQhgENWS9EWhT/v/eIx8afVUlR7szFxR6YAmFfQ/HzB6x3rFo3iZLMOwjDE7McqLG18/iq/KI+rEFcalY9LBGIHiUxcgOhHMJUO0LwMeNPiCXc/6SfRwRPs43eIBW8rVbj/H4D1pHgmSJj44bCFhpU5dFpVsEVlVrEjiBFQr/tq66+ZIF8X3osrrK3qnS64tF7ABwZPm1qqVMbJqM+88cKAot+OH8mzoVWXtQmhzXtV8BTtDxA3Vfa28B ansible-generated on ip-172-31-45-146" >> ~/.ssh/authorized_keys #copy ke semua server

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
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rnchr.anakdevops.online
kubectl -n cattle-system get deploy rancher
kubectl -n cattle-system get deploy rancher -w
```




```
troubleshoot
Error: INSTALLATION FAILED: 1 error occurred:
        * Internal error occurred: failed calling webhook "webhook.cert-manager.io": failed to call webhook: Post "https://cert-manager-webhook.cert-manager.svc:443/mutate?timeout=10s": context deadline exceeded
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

