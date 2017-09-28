packer build $1 2>&1 | tee output.txt
# look for AMI id
#tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > ami.txt
# or
egrep -m1 -oe 'ami-.{8}' output.txt > ami.txt
