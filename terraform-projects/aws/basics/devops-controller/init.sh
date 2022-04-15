#!/bin/bash
# WARNING. WONT WORK FOR MULIPLE HOST.
 terraform plan
 terraform apply 


publicIp="$(terraform output controller_ip | tr -d '[]' | grep -v "^$" | sed s/[\",]//g)"

publicIp=`echo $publicIp |sed s/^\s+//g `



echo $publicIp 


ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ../../../../ansible-playbooks/setup-devops-controller.yml -e serverName=$publicIp -i $publicIp, --tag=docker


jenkinsIp="$(terraform output jenkins_controller_ip | tr -d '[]' | grep -v "^$" | sed s/[\",]//g)"

jenkinsIp=`echo $jenkinsIp |sed s/^\s+//g `

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ../../../../ansible-playbooks/setup-devops-controller.yml -e serverName=$jenkinsIp -i $jenkinsIp,



# ansible-playbook ../../../../ansible-playbooks/setup-devops-controller.yml -e serverName=13.233.146.50 -i 13.233.146.50, --check
