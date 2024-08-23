```
pastikan ssh ke semua server
sudo su
cat /home/serverdevops/cluster.yml #pastikan file sudah ada
```

```
ec2_private_ips = [
  "172.31.38.98",
  "172.31.36.170",
]
```


```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVhoO6jFflmcXBtr9ljHYbSQ/jywbJmtOH8UuU/rrTMszKuJ77ZxGSNBcWCfFelrkv5jmE+aprDpiLA2BKjJn9c7esovdQl7+5+IzWFo+UHCtJGmuyUB6ipmSxOCpnCWU5izegqDVS4T0gwmJWCycJbGViP+Zc9CqOfygfPQKwUuVayYRq/rnG+WIQEUndgZdXNjoCW/F9c555iNcrnLL3Zfc3kMD9cPcoruiQN7ZtDc7O6DzkLST/tz1QSQjvO23McLRy96krKZzkyVrfzgxjuDw6SVLNGvthmHvAM1i7iNFiEUvoyLLVYhLIEQiA8+YqFOLhkeK9w0n9428/7g/5 ansible-generated on ip-172-31-38-98" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqg28Hun+pnt17LAkSB7lWlVfhpZCXACdgKjUs5aNap3DzfS7WaF9Id7H6IIbS74z7y396Im7dTRUzYjyMQU9oECnKBzHfzWoEy/4Mk8vE/1+H7/1YqwN25GaYWORFlTv14cksf09zdHBxBYqRvcuX1m7Wbm5COlFcKTBUibpONxOZhxru4WS/opGbbfQJf7kB9PCMaSyHjEmDJbJfv+QZVPDHvVOJpXN0hJDeqJurdyamTK5+Zp7bqiTAzSfuc19XojcY3gPSxupG2UOdlcVnkjbpzE/PRjMdfFa8IgkqTIBA5SSBe8SOf2IKjfKVaLdEefoGf6yn5PF1aOXu8puH ansible-generated on ip-172-31-36-170" >> ~/.ssh/authorized_keys #copy ke semua server
ssh serverdevops@172.31.38.98
ssh serverdevops@172.31.36.170
```

```
cd /home/serverdevops/
nano cluster.yml #sesuaikan ip
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


