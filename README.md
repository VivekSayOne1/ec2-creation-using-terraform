# jenkins single server creation
vpc and security group set as module 
port 8080 is enabled
if u want to enable any port edit in terraform.tfvars file in root file section
jenkins installation method used in bash script concept in user data section on root file
if we want to grand access to your personal ip edit the terraform.tfvars file , in there the sg_ingress_rules section add ur ip on cidrs value section
for each is used to create single ec2 with single rules if we want to add serveral ec2 add SG2 in root module section and add another eip section setup too and declare the SG2 value in there too
