#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
pe "oc delete namespace amexdemo-faas"
pe "oc new-project amexdemo-faas"
pe "mkdir node1.amex.com"
pe "cd node1.amex.com"
pe "faas create"
pe "faas deploy"
pe "cd .."
pe "mkdir quarkus1.amex.com"
pe "cd quarkus1.amex.com"
pe "faas create -l quarkus -t http"
pe "faas deploy"
