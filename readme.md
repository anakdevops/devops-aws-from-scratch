# RKE v 1.6.1 | Kubernetes v1.27.16 | rancher v2.8.5

```
cp terraform.tfvars.example terraform.tfvars
pastikan anda punya { access_key secret_key } dan masukan ke file terraform.tfvars
```

# init all folder

```
chmod +x init_terraform.sh
./init_terraform.sh
```

# OR

```
cd {folder}
terraform init
```

###########################################################



# Plan

```
chmod +x plan_terraform.sh
./plan_terraform.sh
```

# Apply

```
chmod +x apply_terraform.sh
./apply_terraform.sh
```

# OR

```
cd {folder}
terraform init
terraform plan -var-file="../terraform.tfvars"
terraform apply -var-file="../terraform.tfvars" -auto-approve
```

############################################################################################

# Delete

```
chmod +x destroy_terraform.sh
./destroy_terraform.sh
```

# OR

```
cd {folder}
terraform destroy -var-file="../terraform.tfvars" -auto-approve
```


```
tail -f /var/log/cloud-init-output.log
akses http://jenkins.anakdevops.online/
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
docker logs -f gitlab
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```