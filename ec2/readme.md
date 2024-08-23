```
copy output disini
ec2_private_ips = [
  "172.31.43.69",
  "172.31.41.246",
]
ec2_public_ips = [
  "47.128.147.123",
  "52.221.218.246",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@47.128.147.123
ssh -i security_groups/keypair_anakdevops.pem ubuntu@52.221.218.246
```

```
pastikan ssh ke semua server
sudo su
cat /home/serverdevops/cluster.yml #pastikan file sudah ada
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCt0s0+seG32HAx0db9wRjA5dNcBc+kswpI3kuS+zXWqkL/yKbnJNUB9Qm/AMdhmVQWwJVGVth2ty5CTYpHjyo3CbTjA1M/QDGcUZOAPD02LCN3620zei2nM6w1+Xg7nIponwXxaPOudyDfqR0ahQSCSfkwVCZ43V68IbFrk9/rLbOj++I5T+ZUfCNY+c9oqiV5p9wX0PIheW9adpMFeXDTi5pdq0nHKb0x2ps3qfdmdo26oAZq3FNvCDM9N0JBlsf+pICdlnpETwAqdl1CUkTgez1j69n2iW5glhxWtVdhmrY8DuXcPJ+FbYtMpTSEy/8PSF7HtvyqJfN/ONo273rD ansible-generated on ip-172-31-43-69" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCx/0+/Zy2OkijXiXg671cR5ubHLF/SrJDC5+ligpCFhq5StlQhqCd4ZRsuROihhCJAd5GGYtHWpcB6DzHF8bCbkCvtQiAXiHvPIHbnphbfX+p3Akke5PfGeKH83Wk9mcE+xC8QVRhg3gBwG55T1j29YN/jUWBLbJrlFXe893htv4MbWY98/y1rbsdVNrq8rvDHxKH68qxEn3sYq66UQZGxt4nqbIJIgBYHLQ84M5T8yoeCz9rqsuZTDkYbMR5k/U1WPmcF0HvHCUeBgI2H1k3EObQkqSjqQ1P+VxujPCPqT/qjzavE/APhtr4XuJNjDjNwn/ZhSDwsWxS/6UAT3CkZ ansible-generated on ip-172-31-41-246" >> ~/.ssh/authorized_keys #copy ke semua server
ssh serverdevops@172.31.43.69
ssh serverdevops@172.31.41.246
```

```
cd /home/serverdevops/
nano cluster.yml #sesuaikan ip (hanya edit di server 1)
```

```
cek di semua server
docker --version
docker compose version
helm version
```

```
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=rancher.anakdevops.local
helm list --namespace cattle-system
kubectl -n cattle-system get deploy rancher
kubectl scale --replicas=1 deployment rancher -n cattle-system
kubectl -n cattle-system get deploy rancher -w
```


