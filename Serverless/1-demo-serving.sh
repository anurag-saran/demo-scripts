#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
pe "oc delete namespace amexdemo"
pe "oc delete namespace amexdemo-2"
pe "oc new-project amexdemo"
pe "kn service create greeter \
  --image=quay.io/rhdevelopers/knative-tutorial-greeter:quarkus"
pe "kn service list -n amexdemo"
pe "kn route --namespace amexdemo list"
pe "kn revision list --namespace amexdemo"
pe "for i in {1..5} ; do curl http://greeter-amexdemo.apps.cluster-7d07.7d07.sandbox135.opentlc.com; sleep .05 ; done"
pe "kn service update greeter \
  --env MESSAGE_PREFIX=Namaste \
  --image=quay.io/rhdevelopers/knative-tutorial-greeter:quarkus"
pe "kn revision list --namespace amexdemo"
pe "for i in {1..5} ; do curl http://greeter-amexdemo.apps.cluster-7d07.7d07.sandbox135.opentlc.com; sleep .05 ; done"
pe "oc new-project amexdemo-2"
pe "kn service create greeter \
  --revision-name greeter-v1 \
  --image=quay.io/rhdevelopers/knative-tutorial-greeter:quarkus"
pe "kn service update greeter \
  --revision-name greeter-v2 \
  --env MESSAGE_PREFIX=Namaste \
  --image=quay.io/rhdevelopers/knative-tutorial-greeter:quarkus"
pe "kn revision list --namespace amexdemo-2"
pe "kn service describe --namespace amexdemo-2 greeter"
pe "kn service describe --namespace amexdemo-2 greeter -v"
pe "kn service update greeter --tag=\"greeter-v1=v1\""
pe "kn service update greeter --tag=\"greeter-v2=v2\""
pe "kn service update greeter --tag=\"@latest=latest\""
pe "kn service update greeter \
  --traffic=\"v1=100\" \
  --traffic=\"v2=0\"  \
  --traffic=\"latest=0\""
pe "kn revision list --namespace amexdemo-2"
pe "for i in {1..10} ; do curl http://greeter-amexdemo-2.apps.cluster-7d07.7d07.sandbox135.opentlc.com; sleep .05 ; done"
pe "oc get ksvc greeter -oyaml \
 | yq r - 'status.traffic[*].url'"
pe "kn service update greeter \
  --traffic=\"v1=80\" \
  --traffic=\"v2=20\"  \
  --traffic=\"latest=0\""
pe "for i in {1..50} ; do curl http://greeter-amexdemo-2.apps.cluster-7d07.7d07.sandbox135.opentlc.com; sleep .05 ; done"
pe "kn service create prime-generator \
  --concurrency-target=10 \
  --image=quay.io/rhdevelopers/prime-generator:v27-quarkus"
#pe "watch 'kubectl get pods -n amexdemo-2'"
pe "hey -c 50 -z 10s \
  \"http://prime-generator-amexdemo-2.apps.cluster-7d07.7d07.sandbox135.opentlc.com/?sleep=3&upto=10000&memload=100\""
