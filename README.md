# terraform-ansible-aws-practice
Simple AWS resources(EC2 instances within custom VPC) creation. Using Ansible an automated provision scenario, which deploys a highly available WordPress website creation.

```bash

cd init
export TF_VAR_bucket="terraform-state-aekoow9loo7voh4on5pp"
export TF_VAR_name=app
export TF_VAR_region="us-east-1"
terraform init
terraform apply
cd vpc
terraform init -backend-config="../../backends/test.config"
terraform apply -var-file configs/test.tfvars
cd instances
terraform init -backend-config="../../backends/test.config"
terraform apply -var-file configs/test.tfvars
```
