# RKE v 1.6.1 | Kubernetes v1.27.16

```
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
ssh -i security_groups/keypair_anakdevops.pem ubuntu@47.129.152.68
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.212.234.82
ssh -i security_groups/keypair_anakdevops.pem ubuntu@13.212.33.199
```


```
pastikan ssh ke semua server
sudo su
ll /home/serverdevops/cluster.yml #pastikan file sudah ada dan lanjutkan ke perintah berikut
rke config -l
rke -v
rke config --list-version --all
```

```
su serverdevops
cat /home/serverdevops/.ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1gkAnEH+3qRXkhVIMfPYtQ+f+Bo3V0R8jeEEJKM82/+QghxWnK/YVTwMRXqdFuCzsYe1iuj81CUPQXA7iyjHOzhVDmphrtPSO0znKVIOu51c3mckCRAiFl3N2mLBbCsB6WLobhIcri/O1OnupdIOBdHzHCddLTaiJgfV0rraUmxVTwr1OiQq8hS3VQ63riZBx9eVs3Hmwlw8RGEHSQCfX6pl5pEJYFDlnD59t+dOYnVQ+piJMSlSBrHx9Oa29rsdt+l6aoHasea8XIeSuSJzQprEDGZsIZ5gEzPTeI1frdqopq/H/S27rK2aG2b7sMLMggeH81xZI94tsmbzgT2s7 ansible-generated on ip-172-31-36-96" >> ~/.ssh/authorized_keys #copy ke semua server
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAWEBQrCOwIwT8i/AAiWJ4Bd5WPAU5I1oeXGKRLZYu1jrFhiLk1ogygBk5mG1lVEoVOnOxKhEvCKEibfBnkMUNkBwvtKJXKp/yR6DoNxlVrUwPV7kEYOeu9oF4mJd//mcveGBrjP0VtWFWhV68je794PS/j4LW1RsTH10baYLYRGpTiY1N/tIaEbNr+J7XugfhF2smw3c0Wrr5qUAKirTU8z1hy+yNohv+tLYwUQwcrmslIWvNTkso80bI7Sm8N25al8RLcRNqsiuT5mYqrqVYiDcdTVp4Od2UyiCoGZmUS2N6hnp9jdjjOZoQk6PbWdpI48X1Tm/UOaHzNCHJLfPd ansible-generated on ip-172-31-35-46" >> ~/.ssh/authorized_keys #copy ke semua server
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
chmod +x /tmp/rancherdashboard.sh
cd /tmp && ./rancherdashboard.sh &
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

