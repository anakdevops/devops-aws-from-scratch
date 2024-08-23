# RKE v 1.6.1 | Kubernetes v1.27.16

```
copy output disini
ec2_private_ips = [
  "172.31.24.231",
  "172.31.23.94",
]
ec2_public_ips = [
  "18.141.140.50",
  "13.229.67.48",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@18.141.140.50
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.229.67.48
```


```
pastikan ssh ke semua server
sudo su
ll /home/serverdevops/cluster.yml #pastikan file sudah ada
rke config -l
rke -v
rke config --list-version --all
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDM2nk7+pQ6jbzuTZHVtdOrKKZv5nKm6BMR2y7G5anw0C5XJwAdto84dVMkrDEkeszLAJfnhZf/su9bxCa4FRqla+zHmDthEIm0A2XM1ANwMQrM1LXQwAuBDNe63+bwcCXXdf69NExfIr3DPzTMajwk+6/rz1741bwiIWlrZmJnZBPJtJW5DZJ++K1lf1zlSSFQEcBXZPPMau3/JNseMuXFdBt7tWok5s1uC+bN23A0mKy8Le9gQbpqHGDRW1jhjrx6igZt51UIULqv+1BSU7HvMJ8HDH0wJvP92Qqwr6QexN74gtQgCnqy/gNSWoVfRWNdXc/DVb8bWrS8bco7wp2H ansible-generated on ip-172-31-24-231" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiy9PC5nJh4uE9J7QBRdxk7lD+uZ0IO1bL+38Hr+K5bH1lANWa5cJR0RtDCzPelK3G4MW8gZU95tqpLasEYbNrV+utcz/aDn1eiYnXqG/VsJepiYknvq5m4IGGKjjy/RBRjSCKjNANyyY6FWginy/DtBQNUxCH8RrxrKlQjnSuN4vsIgjxMvuZm4fF5zzTHtG+nfiU7WTElFKieamlPY1yLZw8H+/xk4cFBKNOav0avSlawmIZdvVSzReC7bcjTRg/RWbCBK65OisnULghGSO0nZKR0N9mgzGpzs3dB+D0/vDhJcKzDVjJQ2HRTCty7DMMEOY8ocJvpJdo878ERsuT ansible-generated on ip-172-31-23-94" >> ~/.ssh/authorized_keys #copy ke semua server

copy output disini
ec2_private_ips = [
  "172.31.24.231",
  "172.31.23.94",
]
ec2_public_ips = [
  "18.141.140.50",
  "13.229.67.48",
]
ssh serverdevops@172.31.24.231
ssh serverdevops@172.31.23.94
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
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=clusterkube.anakdevops.online
kubectl -n cattle-system get deploy rancher
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
```

