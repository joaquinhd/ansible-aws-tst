# ansible-aws-tst
## Just testing connections of ansible with aws

## export your keys 
```
export AWS_ACCESS_KEY_ID='<your-access-key>'
export AWS_SECRET_ACCESS_KEY='<your-secret_access-key>'
export AWS_REGION='us-east-1' 
```
### generate private and public keys:
```
mkdir .ssh
ssh-keygen -t rsa -N "" -f .ssh/my_aws
chmod 0664 -R .ssh
```
### and enjoy 
```
ansible-playbook ansible-ec2.yml
```
## warning
Dont forget delete your instances before go to sleep....
