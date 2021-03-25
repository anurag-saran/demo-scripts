#!/usr/bin/env bash

########################
# include the master
########################
. ./demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
#pe "oc new-project amexdemo-eventchannelssubs"
#pe "cd /Users/anuragsaran/Documents/mw/openshift/serverless/knative/eventing"
#pe "kn service create eventinghello \
#  --namespace amexdemo-eventchannelssubs \
#  --concurrency-target=1 \
#  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
#pe "kn source ping create eventinghello-ping-source \
#  --namespace amexdemo-eventchannelssubs \
#  --schedule \"*/2 * * * *\" \
#  --sink eventinghello"
#pe "kn source ping list -n amexdemo-eventchannelssubs"
#pe "kn service --namespace amexdemo-eventchannelssubs list"
pe "oc delete project amexdemo-eventchannelssubs"
pe "oc new-project amexdemo-eventchannelssubs"
pe "kn channel create eventinghello-ch \
  --namespace amexdemo-eventchannelssubs"
pe "kn channel list -n amexdemo-eventchannelssubs"
pe "kn source ping create \
  event-greeter-ping-source \
  --namespace amexdemo-eventchannelssubs \
  --schedule \"*/2 * * * *\" \
  --sink channel:eventinghello-ch"
pe "kn source ping -n amexdemo-eventchannelssubs list"
pe "kn service create eventinghelloa \
  --namespace amexdemo-eventchannelssubs \
  --concurrency-target=1 \
  --revision-name=eventinghelloa-v1 \
  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "kn service create eventinghellob \
  --namespace amexdemo-eventchannelssubs \
  --concurrency-target=1 \
  --revision-name=eventinghellob-v1 \
  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "kn subscription create \
  eventinghelloa-sub \
  --namespace amexdemo-eventchannelssubs \
  --channel eventinghello-ch \
  --sink eventinghelloa"
pe "kn subscription create \
  eventinghellob-sub \
  --namespace amexdemo-eventchannelssubs \
  --channel eventinghello-ch \
  --sink eventinghellob"
pe "kn subscription -n amexdemo-eventchannelssubs list"
pe "kn channel list --namespace amexdemo-eventchannelssubs"
pe "kn source ping --namespace amexdemo-eventchannelssubs list"
pe "kn subscription list --namespace amexdemo-eventchannelssubs"


