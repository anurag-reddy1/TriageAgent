# infra/network
 
Creates the VPC, subnets, route tables, and an optional NAT gateway for TriageAgent.
 
## First-time setup
 
```
cd infra/network
terraform init
terraform apply
```
 
Apply this before `infra/workers`, since the workers launch inside this VPC.
 
## NAT gateway on/off
 
The NAT gateway is off by default to save credits. Turn it on only while testing.
 
```
terraform apply -var="enable_nat=true"    # start testing
terraform apply -var="enable_nat=false"   # done for the day
```
 
While NAT is off, the EC2 workers can't reach SQS, ECR, or Bedrock. S3 and DynamoDB still work through the gateway endpoints.

**PLEASE READ:** `nat.tf` expects a public subnet named `aws_subnet.public` and a private route table named `aws_route_table.private`. Those aren't written yet. I'll use those names when I add them, so if you write any of the network code before I do, please stick with them (or tell me so I can update `nat.tf`).
 
## Outputs
  
Not added yet. I'm planning to expose these so other folders can read them through `terraform_remote_state`:
 
- `vpc_id`
- `private_subnet_ids`
If you're working on `infra/workers`, you can code against these names now. I'll let you know before changing them.
 
## Tearing down
 
Destroy `infra/workers` first, then this folder:
 
```
terraform destroy
```