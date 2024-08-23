```
copy output disini
ec2_private_ips = [
  "172.31.47.92",
  "172.31.32.109",
]
ec2_public_ips = [
  "18.143.156.165",
  "54.255.231.144",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@18.143.156.165
ssh -i security_groups/keypair_anakdevops.pem ubuntu@54.255.231.144
```

```
pastikan ssh ke semua server
sudo su
cat /home/serverdevops/cluster.yml #pastikan file sudah ada
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEstK8UPmpBJkCLuFzgTiIjWe3p6wi6v/wMcp/aIVtUEso1fWSeIYV+G2YK7DcCr+RhmOZW7grDCoDiDYsWZ/o+7JzGirKZfUzjlavmIx48zqRn0I83ouCJvmcW+KCbLTf3ED8ZHzLM8liBz0RpAW5iP5cft9ZW5/QgCS+uCKnyCmXosRwZXjtQN3WpSwndAI10p/aZL4CSPRnYzM7e2pkM2kuodTB6zcxJFwsz3tUREOKGc0fdaf8wnJUJE8O43pla1ua3vCIrswwvwbzdasa9m6ZymzQO2sIWNfsn3XXXGb/1Q/BovhGQyvWl/GnStDeajPTz0cqFaKBt+IQX7jZ ansible-generated on ip-172-31-47-92" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKaxG21WvNCLktoU85xFg1hYTCrgKGvoXTrQ6tLsdGs/wG3C5skP9oNYfE9cyTTOmGgrZHT2GeZH0cfUB6I6vnlfpWdbRhsYT6TTXUjzrKfNr6XjTrzzeBNrP/vG4fprEhtUpkb7KBS0j6kGaxN1Q9i0VrgJmdbXOCniu90XL1MMaJ5AR1tfU1dlhChqImMqVd4Gyj6uRPN/bktWOjpQUbnH1KP2tVhxg6oUeyfAeOw+uV/HNg2dz3Q/nYTgbcJD+LMS6vp4UATH+NTzZCisxz7fjw1M2C7vlqrYWSUuVRRdWmvro2jdZqMVJKwtUK5bZoKqxLLRWu4+h+OYAoXPmh ansible-generated on ip-172-31-32-109" >> ~/.ssh/authorized_keys #copy ke semua server

copy output disini
ec2_private_ips = [
  "172.31.47.92",
  "172.31.32.109",
]
ec2_public_ips = [
  "18.143.156.165",
  "54.255.231.144",
]
ssh serverdevops@172.31.47.92
ssh serverdevops@172.31.32.109
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
reboot all server
```

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=clusterkube.anakdevops.online --set letsEncrypt.ingress.class=nginx
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=clusterkube.anakdevops.online --set letsEncrypt.ingress.class=nginx
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

