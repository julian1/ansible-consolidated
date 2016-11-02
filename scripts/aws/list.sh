

aws ec2 describe-instances  | jq -r '.Reservations[].Instances[]'

# aws ec2 describe-instances  | jq -r '.Reservations[].Instances[]{.InstanceId|.KeyName}'

# should get each instance?
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'

aws ec2 describe-instances | jq -r '.Reservations[].Instances[].State.Name'

