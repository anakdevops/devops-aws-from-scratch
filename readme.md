```
cp terraform.tfvars.example terraform.tfvars
pastikan anda punya { access_key secret_key } dan masukan ke terrafrm.tfvars
```


# Create

```
chmod +x manage_terraform.sh
./manage_terraform.sh
```

# OR

```
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
terraform destroy -var-file="../terraform.tfvars" -auto-approve
```