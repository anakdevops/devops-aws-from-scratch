# Init , Plan , Apply

```
./init_terraform.sh
./plan_terraform.sh
./apply_terraform.sh
./output_terraform.sh
```

# IP All ec2

```
ec2_private_ips = [
  "172.31.20.196", #node 1
  "172.31.42.29",  #node 2
]
ec2_public_ips = [
  "13.229.123.200",
  "13.229.238.30",
]
ec2_private_ips = [
  "172.31.21.72",
]
ec2_public_ips = [
  "54.179.46.197",
]
```



# Single Node | RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
Node 1
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.215.201.93
sudo su
rke config -l
rke -v
rke config --list-version --all
ll /home/serverdevops/cluster.yml
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCep2SOYMefqD3rG3GDXoOVAQEAPjg5Es0r4Zm0huU3LqQBDDZA34Q8jcK5XGlvk5o/8wLUMc9TT+jYqj7hI9S0bZd3xKRFdeTpFPkQTIKzjaZSWaSJxbLTXLcK4efJhGiOHt0N0FWRP/O87NROUweCXGb7MDla9nG16kRctyYHKrvQZUhH2DayJSe+WXx8NBhXWyr1RoDIqhZ1yZlc2x5Yw1vX+WPGnXWJP593JrvyPCfudkEyZPx/JOpU8sEvfVl9GuMqtkW+JSkddfs1Od46jVQWU8SkzUrKBi/j8pHDjzNZZL3kqCzAGJWTOfZf+qUF8njFu1XFypAFMHg1Yq9T ansible-generated on ip-172-31-30-54" >> ~/.ssh/authorized_keys
ssh serverdevops@172.31.20.196
docker --version
docker compose version
helm version
cd /home/serverdevops/
nano cluster.yml
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
```

# Dashboard Rancher

```
sudo su
cd /mnt/s3-bucket
chmod +x dashboard_rancher.sh
./dashboard_rancher.sh
kubectl -n cattle-system get deploy rancher -w #Pastikan semua pod sudah berjalan
akses https://rnchr.anakdevops.online
```


# Add Node | RKE v 1.6.1 | Upgrade Kubernetes v1.27.16 to v1.28.12 (v1.28.12-rancher1-1) | rancher v2.8.5


```
Node 2
ssh -i security_groups/keypair_anakdevops.pem ubuntu@54.169.212.222
sudo su
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3Uf0MKMuPWsRg2ph5ov0SSh1K4iwypNXjTgmwG9l4t2g6rMMBjzLNZAODsohOZDhw+DiwFnr/gN+DDpS7llilMPMRaJ1u9BjcVjURJuZy9f+cmPqPH3rCRi8cRja58JMJZe8551FPyRTNeOcYpauERhRCmxjM+4X6TLDjC1qdHRGvWcoiD/VY9zILy3p55qShRCH9dDINaCRxrbwB6MgudxsoWCmuTOef65loDoTWWiB+SjLiLadnBwApk10icxz9p/JbCZ5ifFlqZtM20feYcEG6dj4bRaIfsqcYIezcDbbdFJ3JGKCa0k/ji5aROfuX9E+kP0VovJt5s+T4fEJL ansible-generated on ip-172-31-45-70" >> ~/.ssh/authorized_keys
ssh serverdevops@172.31.30.54
ssh serverdevops@172.31.45.70
```

```
Node 1
cd /home/serverdevops/
nano cluster.yml #tambahkan ip node 2
jalankan di server 1
rke up --config cluster.yml
INFO[0176] Finished building Kubernetes cluster successfully
export KUBECONFIG=$HOME/kube_config_cluster.yml
kubectl get nodes
akses https://rnchr.anakdevops.online
```



# Destroy

```
./destroy_terraform.sh
```