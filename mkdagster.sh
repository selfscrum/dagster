#!/bin/bash
# call a playbook with some helper variables and an optional start script name

ANSIBLE_PROJECT=mkdagster
CLUSTER_ENV=dev
cs=`dirname $0`
if [ ${cs::1} == '/' ] ; then
      ANSIBLE_ROOT_DIR="`dirname $0`/ansible"
else
      ANSIBLE_ROOT_DIR="`pwd`/`dirname $0`/ansible"
fi

INVENTORY_SNAPSHOT="$ANSIBLE_ROOT_DIR/inventory/snapshot.yml"
export ANSIBLE_ACTION_WARNINGS=False

ansible-playbook -i "$INVENTORY_SNAPSHOT" --extra-vars "{\
      \"env\":\"$CLUSTER_ENV\",\
      \"rootdir\":\"$ANSIBLE_ROOT_DIR\",\
      \"system_cfg\":\"$ANSIBLE_ROOT_DIR/../$ANSIBLE_PROJECT.json\",\
      }" "$ANSIBLE_ROOT_DIR/playbooks/$ANSIBLE_PROJECT.yml" 

