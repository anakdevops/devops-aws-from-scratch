# RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
copy output disini
ec2_private_ips = [
  "172.31.40.198",
  "172.31.44.131",
]
ec2_public_ips = [
  "54.179.145.36",
  "54.255.93.120",
]
ssh -i security_groups/keypair_anakdevops.pem ubuntu@54.179.145.36
ssh -i security_groups/keypair_anakdevops.pem ubuntu@54.255.93.120
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.212.33.199
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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNEKAC0L3hQIDwMABZKT1gLe7uR9QynncHdV3GsPitp8gmPYZwgkVQjtu+eEaCi5mF/7RlgVZMSvv6voSF9A+okMqQS097gUJJ0HWSbH4MlMA7oadb2bXaMZyGxkqPS4wRNdHEQ04ki7aOSFT1+eHdYGA9EdzJJR4NOoSDwnfKH0E4dTeoviNCwbtrdSNbxQLZ7rOL5yAhdEiMdhoNLEt11EAjRGaD7obwuSO2ubz1tc/KbZM5sbYj4pfBbMHvhubtJkJ0BnjMsySUDzdZ/g5xcPKpdgTdBXBD4+UQyTaUeEMgFHWay1+gE/AxEuvk5pH0j4nrEiX3lPs6HTG4xMWZ ansible-generated on ip-172-31-40-198" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClYlhU9yhCZyK4JM4OEp1jnf8Xs/kksgFmXKEEvWhvxvUgnqUNRl4VEiimpBKTfuLpAe4IKN8zU4mGAnkq0eEbsW7QIvECNhU/OEyrMJsnIjP7rCRVXS3x/N8vJhUkokbL/ejmOhdT/pgCq7PVXEN9BuYIdlJOTBMshAwE9bLuNUzIHnea42VB4gvIbp20CUbTu1lsBQ3cfFRMW0ifPukqrtv67R4oth4pdi4AK8XaC2IfkfCkDUTnk12N1ILY/SyJHsFvBiNDTxYAzCfYbl3wcUIvwWa36j3YwJBO/GYgaAOYgT00i9Cqg1pUci46bkalzML5k1MWq8sW2HcZfHMv ansible-generated on ip-172-31-44-131" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDK7sTYhcJNOZUa2U6o4ej4TVs8HWy47fKzfUjR+2INr2DOTQSGwnDYxb0cIfB4NHe4Kx/IXx4WmvTd8V7OTf3iyxbi2T6Yrxb1lX8EdkrplT1GtoSYr5dNd4+vBn4PwQA9vTNTNBfYVZRR84YW4+jf4ihxvaAnU0PmyXBBpy+rlOPgda25CadaA+Pc4RVNHl65M4psNQY3AovK62AkouvVxY2Rnch3+woG96MF9jN6qVo+tOkCwgGIpajKWRL0ke5hxwnm3cKRoMO0TZYaArtCi8qiYwmV2ZxIfEpZ6UJV6MAsxSpB9EPV9d812dVeV6g3KfaSn7vcdfNHwcOnNwYx ansible-generated on ip-172-31-42-137" >> ~/.ssh/authorized_keys #copy ke semua server

copy output disini
ec2_private_ips = [
  "172.31.36.96",
  "172.31.35.46",
  "172.31.42.137",
]
ec2_public_ips = [
  "47.129.152.68",
  "13.212.234.82",
  "13.212.33.199",
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
jalankan di server 1
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.2
helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=kube.anakdevops.online
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

