#!/bin/sh
# Static parameters
WORKSPACE=$(
  cd $(dirname "$0")
  pwd
)
BOX_PLAYBOOK=$WORKSPACE/box_docker.yml
BOX_NAME=awx_box
BOX_ADDRESS=$REMOTE_HOST
BOX_USER=$BOX_DEPLOY_USER
BOX_PWD=$BOX_DEPLOY_PASS
BOX_PROVIDER=${BOX_PROVIDER:-}
ENVIRONMENT=${ENVIRONMENT:-default}

prudentia ssh <<EOF
unregister $BOX_NAME

register
$BOX_PLAYBOOK
$BOX_NAME
$BOX_ADDRESS
$BOX_USER
$BOX_PWD

verbose 1
set box_address $BOX_ADDRESS
set ansible_become_password $BOX_PWD

set box_provider $BOX_PROVIDER
set env $ENVIRONMENT

provision $BOX_NAME
EOF
