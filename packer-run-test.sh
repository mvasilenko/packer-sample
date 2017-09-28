#!/usr/bin/env bash
for j in *.json; do
    packer build ${j} 2>&1 | tee output.txt
    if [ $? -ne 0 ]; then
        echo "packer build fail for ${j}"
    fi
# look for AMI id
#   tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > ami.txt
#   OR
    ami_id=`tail -2 output.txt | egrep -m1 -oe 'ami-.{8}'`
    echo ${ami_id} >> ami.txt
# clean up, remove image after successfull packer run
    aws ec2 deregister-image --image-id ${ami_id}
done
