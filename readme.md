# RKE v 1.6.1 | Kubernetes v1.27.16

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



# Create

```
chmod +x manage_terraform.sh
./manage_terraform.sh
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