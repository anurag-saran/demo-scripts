#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
pe "oc delete namespace amexdemo-camelk"
pe "oc new-project amexdemo-camelk"
pe "kamel install"
pe "cd word-phrases"
pe "cat messages-channel.yaml"
pe "kubectl create -f messages-channel.yaml"
pe "cat words-channel.yaml"
pe "kubectl create -f words-channel.yaml"
pe "cat printer.groovy"
pe "kamel run printer.groovy"
pe "cat splitter.groovy"
pe "kamel run splitter.groovy"
pe "cat feed.groovy"
pe "kamel run feed.groovy"
